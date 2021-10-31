provider "aws" {
  region = "sa-east-1"
  access_key = "AKIA5WNURJQIGYQD7PGO"
  secret_key = "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"
}

variable "name" {
  default = "AWS_WIN2019"
}

resource "aws_key_pair" "main" {
  key_name   = "clouddevops"
  public_key = "${file("clouddevops.pub")}"
}

resource "aws_security_group" "main" {
  name = "${var.name}-security-group"
  
  tags = {
    Name = "${var.name}-security-group"
  }
  
  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami = "ami-048fe32495ea857a6"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.main.id}"]
  
  key_name = "${aws_key_pair.main.key_name}"
  
  root_block_device {
    volume_type = "standard"
    volume_size = "30"
    delete_on_termination = true
  }

  tags = {
    "Name" = "InstanciaCloudDevopsTeam2",
    "Año" = "2021",
    "SO" = "Windows Server 2019",
    "Equipo" = "Team2",
    "Carrera" = "CloudDevOps",
    "Institución" = "EducacionIT",
    "Proyecto" = "CloudDevOps",
    "Entorno" = "Development"
  }
}