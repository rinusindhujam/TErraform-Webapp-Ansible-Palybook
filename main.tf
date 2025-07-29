provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "Terra_Key" {
  key_name   = "Terra_Key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF1Fjwo2DPIjVk+ZgE+sg/L3a5q5+9JsPAN834Ow/5sZ9D21Ld2R24vDuGl8EKxdL27wn+40B3AOy1B6hOnk0zktsddlx6gwPOKTiTsVK9S/F/8bxOMjNZm+IO/xMZDhEc4j2e9AZNpLrxvDzfBCEWaQNqzWlfbUBbVVxmpZLMRFJd1IgVkr0nr11ysWWBR2w905SWfEzUQQPgRHhoEzyrQo7rNQG/c74ULwclakcISBsZZc1MY/CXMfirGPf1cnzpQu3TBfr4ejTQbIhSUTQFy4ibxLNe4gPN/zz6hxRqYexuLio1yFsZpKjth8nYq5bn4mlrcPTGKOyG2h4q5Ve1ruFrevPj1/63z7Z6/hefsmFf/IP/HZwgrElku9ar2p3lIm0iFYM9lN5u8JiGPis0tbc4NVrli1M+ETBAfqiOZXdX0f6m24cOnY368HIIsrsau/SjH1sjnhJr4h9a+J1FnBrFWNo0KoxNwJqadKdp6QJ1NTbW3XqPU+04PONAeldoDNtm8wjJqAyyN6qxgtbEujWQwiitIGDuRq2bwJOErqVea+a/u2XuMhvA8+OZ36cuGGKa3S0PKClbH6zCxHA8fg0DK7P2PunLEv4+Qwp/3TOHX7ld9RIpRfxMHEYqnI94HMJpnFx4dbfO5dSvdrH1NJ/rYUSbSHuVg23CK8/5KQ== your_email@example.com"
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-03bb6d83c60fc5f7c" # Amazon Linux 2 AMI (check region)
  instance_type = "t2.micro"
  key_name      = "Terra_Key"  
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  tags = {
    Name = "WebServer"
  }

  provisioner "local-exec" {
    command = "echo [web] > ../ansible/inventory.ini && echo ${self.public_ip} >> ../ansible/inventory.ini"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
