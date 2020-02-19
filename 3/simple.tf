provider "aws" {
  region = "eu-central-1"
}

variable "env" {
  default = "prod"
}
variable "prod_owner" {
  default = "Artem Havrylenko"
}
variable "test-owner" {
  default = "test Artem Havrylenko"
}
resource "aws_instance" "my_first_tf_instance" {
  ami           = "ami"
  instance_type = (var.env == "prod" ? "t3.large" : "t3:micro")

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? "var.prod_owner" : "var.test-owner"
  }
}
