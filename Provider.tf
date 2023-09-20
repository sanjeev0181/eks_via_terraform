terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"

}
# Create S3 Bucket

terraform {
  backend "s3" {
    bucket = "terraform-jenkins-bucket02"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
