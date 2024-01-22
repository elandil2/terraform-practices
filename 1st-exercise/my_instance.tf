#provider there are different options but we will use aws.
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "intro_terraform" {
  ami                    = "ami-0c2f3d2ee24929520"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-2a"
  key_name               = "terra-key"
  vpc_security_group_ids = ["sg-071ac36453f183531"]
  tags = {
    Name = "Terraform-Instance"
    Project = "Terraform"
  }
}
 