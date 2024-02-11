data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

data "aws_key_pair" "existing_key_pair" {
  key_name = "Igho_NOVA_Key"  # Replace with the name of your existing key pair
}

resource "aws_instance" "appserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  vpc_security_group_ids = [ aws_security_group.app_SG.id ]
  key_name = data.aws_key_pair.existing_key_pair.key_name  # Use the existing key pair name
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt install docker.io -y
              sudo apt install python3-pip -y
              sudo pip3 install psutil flask
              sudo apt install git
              mkdir /home/ubuntu/app
              mkdir /home/ubuntu/app2
              cd /home/ubuntu/app
              git clone https://github.com/Omonigho4/flask-hello-world.git
              cp -r flask-hello-world/* /home/ubuntu/app2
              cd /home/ubuntu/app2 
              sudo docker build -t myflaskappv1 .
              sudo docker run -p 5000:5000 myflaskappv1
              EOF

            

  tags = {
    Name = "Flask-Appserver"
  }
}