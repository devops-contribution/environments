terraform {
  backend "s3" {
    bucket         = var.bucket_name
    key            = "customer-01/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.table_name
  }
}
