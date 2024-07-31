provider "kubernetes" {
  config_path = var.kube_config_path
}

module "salim_postgres" {
  source            = "./modules/salim_database"
  name              = "salim"
  type              = "postgres"
  container_port    = 5432
  database_image    = "postgres:latest"
  node_port         = 0
  db_password       = var.postgres_password
}

module "salim_mysql" {
  source            = "./modules/salim_database"
  name              = "salim"
  type              = "mysql"
  container_port    = 3306
  database_image    = "mysql:latest"
  node_port         = 0
  db_password       = var.mysql_password
}


