resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name    = "${var.name}-${terraform.workspace}-main-gw"
    Product = "${var.name}"
    Env     = "${terraform.workspace}"
  }
}
