

NOTES:
** Please be patient while the chart is being deployed **

MinIO(R) can be accessed via port 9000 on the following DNS name from within your cluster:

   my-release-minio.default.svc.cluster.local

To get your credentials run:

   export ACCESS_KEY=$(kubectl get secret --namespace default my-release-minio -o jsonpath="{.data.access-key}" | base64 --decode)
   export SECRET_KEY=$(kubectl get secret --namespace default my-release-minio -o jsonpath="{.data.secret-key}" | base64 --decode)

To connect to your MinIO(R) server using a client:

- Run a MinIO(R) Client pod and append the desired command (e.g. 'admin info'):

   kubectl run --namespace default my-release-minio-client \
     --rm --tty -i --restart='Never' \
     --env MINIO_SERVER_ACCESS_KEY=$ACCESS_KEY \
     --env MINIO_SERVER_SECRET_KEY=$SECRET_KEY \
     --env MINIO_SERVER_HOST=my-release-minio \
     --image docker.io/bitnami/minio-client:2021.5.18-debian-10-r3 -- admin info minio

To access the MinIO(R) web UI:

- Get the MinIO(R) URL:

   echo "MinIO(R) web URL: http://127.0.0.1:9000/minio"
   kubectl port-forward --namespace default svc/my-release-minio 9000:9000

     kubectl run --namespace minio my-release-minio-client --rm --tty -i --restart='Never' --env MINIO_SERVER_ACCESS_KEY=$ACCESS_KEY --env MINIO_SERVER_SECRET_KEY=$SECRET_KEY --env MINIO_SERVER_HOST=minio --image docker.io/bitnami/minio-client:2021.5.18-debian-10-r3 -- admin bucket

     kubectl run --namespace minio my-release-minio-client --rm --tty -i --restart='Never' --env MINIO_SERVER_ACCESS_KEY=$ACCESS_KEY --env MINIO_SERVER_SECRET_KEY=$SECRET_KEY --env MINIO_SERVER_HOST=minio --image docker.io/bitnami/minio-client:2021.5.18-debian-10-r3 -- admin info minio
