# Public
resource "aws_subnet" "subnet-public-a" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,1)}"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name    = "${var.name}-${terraform.workspace}-subnet-public-a"
    Product = "${var.name}"
    Env     = "${terraform.workspace}"
  }
}

resource "aws_subnet" "subnet-public-c" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,2)}"
  availability_zone = "${var.aws_region}c"

  tags = {
    Name    = "${var.name}-${terraform.workspace}-subnet-public-c"
    Product = "${var.name}"
    Env     = "${terraform.workspace}"
  }
}

# Private

# resource "aws_subnet" "subnet-private-a" {
#   vpc_id            = "${aws_vpc.vpc.id}"
#   cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,65)}"
#   availability_zone = "${var.aws_region}a"

#   tags = {
#     Name    = "${var.name}-${terraform.workspace}-subnet-private-a"
#     Product = "${var.name}"
#     Env     = "${terraform.workspace}"
#   }
# }

# resource "aws_subnet" "subnet-private-c" {
#   vpc_id            = "${aws_vpc.vpc.id}"
#   cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block,8,66)}"
#   availability_zone = "${var.aws_region}c"

#   tags = {
#     Name    = "${var.name}-${terraform.workspace}-subnet-private-c"
#     Product = "${var.name}"
#     Env     = "${terraform.workspace}"
#   }
# }
