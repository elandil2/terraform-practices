# we defined variables Region, AZ, AMIs
variable "REGION" {
  default = "us-east-2"
}
#Specifies the default availability zone within the region as "us-east-2a."
variable "ZONE1" {
  default = "us-east-2a"
}
#Specifies a map of AWS regions to corresponding AMI IDs for different regions.
variable "AMIS" {
  type = map(any)
  default = {
    "us-east-1" = "ami-0c0b74d29acd0cd97"
    "us-east-2" = "ami-0c2f3d2ee24929520"
  }
}
#Specifies the default username ("ec2-user") used for connecting to the EC2 instance.
variable "USER" {
  default = "ec2-user"

}