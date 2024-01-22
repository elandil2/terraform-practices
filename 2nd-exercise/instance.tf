resource "aws_instance" "terraform_step2" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "terra-key"
  vpc_security_group_ids = ["sg-031937cfc36f8cc91"]
  tags = {
    Name    = "Terraform-Instance"
    Project = "Terraform"
  }
}