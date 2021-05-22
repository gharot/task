# Jak přidat další exportery:

1. vypsat si aktivní endpointy

    ```bash
    kubectl -n monitoring get endpoints
    -------------------
    alertmanager-main              10.244.0.71:9093                                     26m
    alertmanager-operated          10.244.0.71:9094,10.244.0.71:9094,10.244.0.71:9093   26m
    grafana                        10.244.0.81:3000                                     26m
    kube-state-metrics             10.244.0.87:8443,10.244.0.87:9443                    26m
    node-exporter                  10.110.0.3:9100                                      26m
    prometheus-adapter             10.244.0.105:6443                                    26m
    prometheus-k8s                 10.244.0.14:9090                                     26m
    prometheus-operated            10.244.0.14:9090                                     16m
    prometheus-operator            10.244.0.116:8443                                    26m
    prometheus-postgres-exporter   10.244.0.40:9187                                     26m
    ```

2. Vytvoříme soubor `prometheus-additional.yaml`
3. jeho hodnota je obsah endpointu, který nás zajímá (mění se vždy při redeployi - lepčí udělat pomocí proměnné)
4. vygenerovat secret `kubectl create secret generic additional-scrape-configs --from-file=prometheus-additional.yaml --dry-run -oyaml > additional-scrape-configs.yaml`
5. do vygenerovaného secretu přidat správný namespace
6. do souboru `kustomize/base/services/monitoring/prometheus/Prometheus.yaml` přidat do `spec` rádky:

    ```bash
    additionalScrapeConfigs:
        name: additional-scrape-configs
        key: prometheus-additional.yaml
    ```
    
