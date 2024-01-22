terraform {
  backend "s3" {
    bucket = "terraform-exercise-try1"
    key    = "terraform/backend"
    region = "us-east-2"
  }
}