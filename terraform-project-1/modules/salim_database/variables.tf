variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "type" {
  description = "Type of the database (e.g., postgres, mysql)"
  type        = string
}

variable "container_port" {
  description = "Port on which the container will listen"
  type        = number
}

variable "database_image" {
  description = "Docker image for the database"
  type        = string
}

variable "node_port" {
  description = "NodePort for the service"
  type        = number
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}