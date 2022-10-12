output "my_server_ip" {
  value = aws_eip.my_static_ip.public_ip
}

output "my_sg_id" {
  value = aws_security_group.web.id
}
