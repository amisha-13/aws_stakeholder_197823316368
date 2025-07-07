terraform {
  backend "s3" {
    bucket = "terraform-training-s3-bucket"
    key    = "197823316368_terraform.tfstate"
    region = "ap-south-1"
  }
}