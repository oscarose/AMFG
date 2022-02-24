terraform {
  backend "s3" {
    bucket = "terraform-ogba-comcast"
    region = "us-east-1"
    key = "terraform.tfstate"
  }
}
