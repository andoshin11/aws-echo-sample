variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "ap-northeast-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

terraform {
   backend "remote" {
      organization = "studio-andy"
      workspaces {
         name = "aws-echo-sample"
      }
   }
}

module "base" {
  source = "./modules"
  aws_region = "${var.aws_region}"
}
