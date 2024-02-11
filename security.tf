resource "aws_security_group" "app_SG" {
  name_prefix = "FlaskApp-"

tags = {
    Name="App_SG"
}
}

# Allow incoming HTTP (port 80) traffic
resource "aws_security_group_rule" "inbound_http_traffic" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app_SG.id
}

# Allow incoming SSH (port 22) traffic
resource "aws_security_group_rule" "inbound_ssh_traffic" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app_SG.id
}
# Allow incoming Flsk/python (port 5000) traffic
resource "aws_security_group_rule" "inbound_app_traffic" {
  type        = "ingress"
  from_port   = 5000
  to_port     = 5000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app_SG.id
}
resource "aws_security_group_rule" "download_patch" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app_SG.id
}