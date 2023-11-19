variable "vpc_id" {
  type    = string
  default = "vpc-07b29bf03817840e5"
}

variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "public_subnets" {
  type = map(string)

  default = {
    "a" : "subnet-06240758a52eb3483",
    "b" : "subnet-02ecbb6787cf5cde2"
  }
}

variable "instance_ami" {
  type    = string
  default = "ami-09e70258ddbdf3c90"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
