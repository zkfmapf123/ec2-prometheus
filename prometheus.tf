###########################################################
## prom-ec2-sg
###########################################################
resource "aws_security_group" "prom-ec2-sg" {
  name   = "prom-ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "from to ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "from to prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "from to https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ping test"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "node-ec2-sg"
  }
}

###########################################################
## node-ec2
###########################################################
module "prom-ec2" {
  source  = "zkfmapf123/simpleEC2/lee"
  version = "1.0.7"

  instance_name      = "prom-ec2"
  instance_region    = "ap-northeast-2a"
  instance_subnet_id = lookup(var.public_subnets, "a")
  instance_sg_ids    = [aws_security_group.prom-ec2-sg.id]

  instance_ami = var.instance_ami
  #   instance_iam  = aws_iam_instance_profile.ssm-profile.name
  instance_type = var.instance_type

  instance_ip_attr = {
    is_public_ip  = true
    is_eip        = false
    is_private_ip = false
    private_ip    = ""
  }

  instance_key_attr = {
    is_alloc_key_pair = false
    is_use_key_path   = true
    key_name          = ""
    key_path          = "~/.ssh/id_rsa.pub"
  }
}
