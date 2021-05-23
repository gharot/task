terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
    }
  }

  required_version = ">= 0.13"
}
provider "postgresql" {
  host = "localhost"
  port = 5432
  database = "postgres"
  username = "postgres"
  password = "SkIy3PdxGA"
  sslmode  = "disable"
}

resource "postgresql_database" "my_db" {
  name              = "pokus"
  owner             = "postgres"
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
}