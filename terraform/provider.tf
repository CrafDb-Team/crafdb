provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      "owner"         = var.aws_resource_owner
      "created-using" = "terraform"
    }
  }

}
