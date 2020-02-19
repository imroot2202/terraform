provider "aws" {
  region = "ca-central-1"
}

/*resource "aws_eip" "static_ip_1" {
  instance = aws_instance.my_web1.id
  tags = {
    name  = "Web Server IP"
    Owner = "Artem Havrylenko"
  }
}
*/
resource "aws_instance" "my_web1" {
  count                  = 3
  ami                    = "ami-07ab3281411d31d04"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.for_test_web_server.id]
  user_data = templatefile("./user_data.sh.tpl", {
    count_s = "${count.index}",
    f_name  = "Artem",
    l_name  = "Havrylenko",
    names   = ["Вася", "Петя", "Коля", "Оля", "Таракан", "Толя"]
  })
  tags = {
    Name          = "Test_wes_server"
    Owner         = "Artem Havrylenko"
    Server_number = "${count.index}"
  }
  lifecycle {
    create_before_destroy = true
  }
}
#-------------------
resource "aws_security_group" "for_test_web_server" {
  name = "for_test_web_server"
  dynamic "ingress" {
    for_each = ["80", "8080", "22", "3306", "1818"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name        = "for_test_web_server"
    owner       = "Havrylenko Artem"
    description = "builded from terraform"
  }
}
