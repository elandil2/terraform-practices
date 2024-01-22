
# Defines an AWS key pair resource. It creates an SSH key pair named "terra-key3" with the public key loaded from the file "terra-key3.pub."
resource "aws_key_pair" "terra-key" {
  key_name   = "terra-key3"
  public_key = file("terra-key3.pub")
}
#Defines an AWS EC2 instance resource. It uses the specified AMI, instance type, availability zone, key pair, security group, and tags. 
#it includes two provisioners:


resource "aws_instance" "terraform_step3" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.terra-key.key_name
  vpc_security_group_ids = ["sg-080b2c9b6691b2b13"]
  tags = {
    Name    = "Terraform-Instance3"
    Project = "Terraform3"
  }
  #Copies the local script "web.sh" to the "/tmp/web.sh" path on the remote EC2 instance.
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }
  #Executes commands on the remote instance to make the script executable and then runs it with elevated privileges
  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  #make instance ip public for ec2 instance use key that we generated before
  connection {
    user        = var.USER
    private_key = file("terra-key3")
    host        = self.public_ip
  }
}

output "PublicIP" {
  value = aws_instance.terraform_step3.public_ip
}

output "PrivateIP" {
  value = aws_instance.terraform_step3.private_ip
}