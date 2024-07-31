variable "kube_config_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "postgres_password" {
  description = "Password for the Postgres database"
  type        = string
  sensitive   = true
}

variable "mysql_password" {
  description = "Password for the MySQL database"
  type        = string
  sensitive   = true
}