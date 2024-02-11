terraform {

  required_version = ">= 1.0.0"
  backend "s3" {
    bucket         = "craft-beer-db-terraform-backend"
    key            = "craftdb/rds/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "craft-beer-db-terraform-lock"
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      "owner"         = var.aws_resource_owner
      "created-using" = "terraform"
    }
  }

}


