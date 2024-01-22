# we defined variables Region, AZ, AMIs
variable "REGION" {
  default = "us-east-2"
}

variable "ZONE1" {
  default = "us-east-2a"
}

variable "AMIS" {
  type = map(any)
  default = {
    "us-east-1" = "ami-0c0b74d29acd0cd97"
    "us-east-2" = "ami-0c2f3d2ee24929520"
  }
}
