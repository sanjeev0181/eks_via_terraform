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

resource "aws_s3_bucket" "example" {
  bucket = "terraform.tfstate"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}