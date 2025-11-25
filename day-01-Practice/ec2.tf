data "aws_ami" "main_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


data "aws_key_pair" "main_key_pair" {
  key_name = "terraform"
}



resource "aws_instance" "main_ec2" {
  ami                         = data.aws_ami.main_ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.main_public_subnet.id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = data.aws_key_pair.main_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.main_sg.id]

  user_data = <<-EOF
		    #!/bin/bash
		    sudo apt update -y
	EOF

  user_data_replace_on_change = true

  tags = {
    Name = "${var.name}_main_ec2"
  }
}
