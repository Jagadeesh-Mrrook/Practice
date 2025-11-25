#VPC variables values

cidr_block    = "10.0.0.0/16"
dns_support   = true
dns_hostnames = true
name          = "Practice-vpc"

##Subnet variables values
#Public Subnet

public_cidr_block        = "10.0.1.0/24"
public_availability_zone = "ap-south-1a"
public_ip_onlaunch       = true

#Private Subnet

private_cidr_block        = "10.0.2.0/24"
private_availability_zone = "ap-south-1b"
private_ip_onlaunch       = false

#Public RT
destination_cidr = "0.0.0.0/0"

#Security Group

sg_ingress_ports = [22, 80, 443]


#NACL

nacl_rule = {
  "ssh_ingress" = {
    rule_number = 100
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
  },

  "http_ingress" = {
    rule_number = 110
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },
  "https_ingress" = {
    rule_number = 120
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 443
    to_port     = 443
  },

  "all_egress" = {
    rule_number = 200
    egress      = true
    protocol    = "-1"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }
}



##EC2 vaiables

instance_type               = "t2.micro"
associate_public_ip_address = "true"
