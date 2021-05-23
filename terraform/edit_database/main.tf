terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
    }
    sops = {
      source = "carlpett/sops"
      version = "~> 0.5"
    }
  }

  required_version = ">= 0.13"
}

provider "sops" {}

data "sops_file" "database-secrets" {
  source_file = "../terraform-secrets.enc.yaml"
}

provider "postgresql" {
  host = "localhost"
  port = 5432
  database = "postgres"
  username = data.sops_file.database-secrets.data["username"]
  password = data.sops_file.database-secrets.data["password"]
  sslmode  = "disable"
}

resource "postgresql_database" "my_db" {
  name              = "pepa"
  owner             = "postgres"
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
}