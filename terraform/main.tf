provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "echo-sample-tfstate"
    key    = "echo-sample.terraform.tfstate" // tfstate name
    region     = "ap-northeast-1" // cannot use variable here
    profile = "default"
    encrypt = true
  }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "echo-sample-tfstate"
  versioning {
    enabled = true
  }
}
