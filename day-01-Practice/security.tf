resource "aws_security_group" "main_sg" {
  name        = "main_sg"
  description = "Allow ssh connectivity"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.name}_main_sg"
  }
}

resource "aws_security_group_rule" "main_sg_ssh" {
  for_each = toset(var.sg_ingress_ports)

  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main_sg.id
}


resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 0
  security_group_id = aws_security_group.main_sg.id
}

#NACL
resource "aws_network_acl" "main_nacl" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}_main_nacl"
  }
}

resource "aws_network_acl_rule" "main_nacl_rules" {
  for_each       = var.nacl_rule
  network_acl_id = aws_network_acl.main_nacl.id
  rule_number    = each.value.rule_number
  egress         = each.value.egress
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}


resource "aws_network_acl_association" "main_public" {
  network_acl_id = aws_network_acl.main_nacl.id
  subnet_id      = aws_subnet.main_public_subnet.id
}

resource "aws_network_acl_association" "main_private" {
  network_acl_id = aws_network_acl.main_nacl.id
  subnet_id      = aws_subnet.main_private_subnet.id
}
