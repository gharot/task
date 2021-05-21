## Work to do

### Deploy to K8S

- [ ] Cert-manager
- [ ] External-DNS
- [x] Ingress-nginx
- [x] Metrics-server
- [x] GHA runner/operator
- [ ] Grafana
- [ ] Prometheus Operator
- [ ] Node exporter
- [ ] Postgresql database
- [ ] Bookstore app
- [ ] Backup tool
- [ ] "S3" bucket for backup

## Other work

- [x] CI-helper image
- [x] Wokrflow - build + push CI-helper image
- [x] Workflow - deploy to K8S
- [ ] Terraform - s3 Bucket
- [ ] Terraform - RDS Postgresql
- [ ] Terraform - edit RDS
- [ ] DNS server


-------------------------------------------------------------------------

## List of tools and its versions

* Terraform (**0.15.1**) - [official site](https://www.terraform.io/downloads.html)
* Terragrunt (**0.29.0**) - [official site](https://terragrunt.gruntwork.io/docs/getting-started/install/)
* sops (**3.7.1**) - [official site](https://github.com/mozilla/sops)
* helm (**3.5.4**) - [official site](https://helm.sh/)
* kustomize (**4.1.2**) - [official site](https://kustomize.io/)
* Plugin SopsSecretGenerator for kustomize (**1.4.0**) - [official site](https://github.com/goabout/kustomize-sopssecretgenerator/)

## Install and configure your system
Install direnv, curl, unzip.

### Linux

##### Ubuntu
```bash
sudo apt update
sudo apt install direnv curl unzip
```

### MacOS
```bash
brew install coreutils
# https://github.com/kubernetes-sigs/kustomize/blob/master/hack/install_kustomize.sh
./install_kustomize.sh 3.8.7
```

### Install needed tools

```bash
./tools/bin/install-all.sh
```
It installs all needed tools in correct version which is set in file `tools.env`.
If there are new version of binaries in `tools.env` you can run this script again and install newest versions.


#### Allow `.envrc` usage in repo dir
If `.envrc` will change you have to confirm this change by running following command.

```bash
direnv allow
```

### Install Homebrew on Linux

The Missing Package Manager for macOS (or Linux) - https://brew.sh/

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Install `kubectl`
```bash
    brew install kubectl
    kubectl version --short
```