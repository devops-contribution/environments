terraform {
  backend "s3" {
    bucket         = "terraform-remote-be-bucket"
    key            = "customer-01/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
