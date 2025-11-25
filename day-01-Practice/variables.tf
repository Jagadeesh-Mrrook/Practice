#VPC varables are defined here

variable "cidr_block" {
  type = string
}

variable "dns_support" {
  type = bool
}

variable "dns_hostnames" {
  type = bool
}

variable "name" {
  type = string
}

##Subnets variables are defined here

#Public Subnet
variable "public_cidr_block" {
  type = string
}

variable "public_availability_zone" {
  type = string
}

variable "public_ip_onlaunch" {
  type = bool
}

#Private Subnet
variable "private_cidr_block" {
  type = string
}

variable "private_availability_zone" {
  type = string
}

variable "private_ip_onlaunch" {
  type = bool
}

#Public RT

variable "destination_cidr" {
  type = string
}

#Security Group

variable "sg_ingress_ports" {
  type = list(string)
}

#NACL

variable "nacl_rule" {
  description = "all egress an ingress rules are defined"
  type = map(object({
    rule_number = number
    egress      = bool
    protocol    = string
    rule_action = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

##EC2 variables

variable "instance_type" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}
