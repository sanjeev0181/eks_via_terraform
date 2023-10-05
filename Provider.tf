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

# terraform {
#   backend "s3" {
#     bucket = "terraform-jenkins-bucket02"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#   }
# }

resource "aws_s3_object" "object" {
  bucket = "terraform_suppu_s3_bucket"
  key    = "terraform.tfstate"
  source = "path/to/file"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  # etag = filemd5("path/to/file")
}
