#!/bin/sh
# expected variables:
# PGHOST
# PGPORT
# PGDATABASE
# PGUSER
# PGPASSWORD
# PGEXTENSION

NEW_DB_NAME=$(echo $TENANT_NAMESPACE | tr .- __)
NEW_USER_NAME=${NEW_DB_NAME}_user

NEW_PASS=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c32)

psql -c "CREATE DATABASE ${NEW_DB_NAME};" || echo "Database ${NEW_DB_NAME} probably already exists" 
psql -c "CREATE USER ${NEW_USER_NAME};" || echo "User ${NEW_USER_NAME} probably already exists"
psql -c "ALTER USER ${NEW_USER_NAME} WITH NOCREATEDB;"
psql -c "ALTER USER ${NEW_USER_NAME} WITH ENCRYPTED PASSWORD '${NEW_PASS}';"
psql -c "GRANT ALL PRIVILEGES ON DATABASE ${NEW_DB_NAME} TO ${NEW_USER_NAME};"

export PGEXTENSION=$(echo ${PGEXTENSIONS} | grep -o '[^[:space:]]\+' | sed 's/,//')
for EXTENSION in ${PGEXTENSION}; do    
    psql -d ${NEW_DB_NAME} -c "CREATE EXTENSION ${EXTENSION};"
done

for val in $V; do
    echo $val
done

# create secret
kubectl -n ${TENANT_NAMESPACE} delete secret postgresql --ignore-not-found
kubectl -n ${TENANT_NAMESPACE} create secret generic postgresql --from-literal=password=${NEW_PASS_BASE64} --generator="secret/v1" --output="yaml" --validate

# create configmap
kubectl -n ${TENANT_NAMESPACE} delete configmap postgresql --ignore-not-found
kubectl -n ${TENANT_NAMESPACE} create configmap postgresql --from-literal=host=${PGHOST} --from-literal=port=${PGPORT} --from-literal=database=${NEW_DB_NAME} --from-literal=user=${NEW_USER_NAME} --generator="configmap/v1" --output="yaml" --validate
