provider "aws" {
  region = "eu-west-1"

}

resource "aws_instance" "myfirst_instance" {
  ami           = "ami-0713f98de93617bb4"
  instance_type = "t3.micro"
  tags = {
    Name  = "super instance"
    Owner = "Artem Havrylenko"
    Phone = "2575"
  }
}

resource "aws_instance" "mySecond_instance" {
  count         = 2
  ami           = "ami-0713f98de93617bb4"
  instance_type = "t2.micro"
  tags = {
    Name  = "super instance 2"
    Owner = "Artem Havrylenko"
    Phone = "2575"
  }
}
