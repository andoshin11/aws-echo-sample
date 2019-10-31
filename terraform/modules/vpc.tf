resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    "Name"    = "${var.name}-${terraform.workspace}-vpc"
    "Product" = "${var.name}"
    "Env"     = "${terraform.workspace}"
  }
}
