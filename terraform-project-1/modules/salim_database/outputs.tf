output "nginx_service_name" {
  value = kubernetes_service.nginx.metadata[0].name
}

output "database_service_name" {
  value = kubernetes_service.database.metadata[0].name
}
