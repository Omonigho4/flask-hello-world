output "appserver_publicIP" {
  value = aws_instance.appserver.public_ip
}
