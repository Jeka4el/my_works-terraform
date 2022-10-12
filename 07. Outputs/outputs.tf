output "webserver_instance_id" {
  value = aws_instance.MyWebServer.id

}

output "webserver_public_ip" {
  value = aws_instance.MyWebServer.public_ip

}

output "SG-id" {
  value       = aws_security_group.MyWebServer.id
  description = "This is SecuerityGroup ARN" # Заметка для себя
}
