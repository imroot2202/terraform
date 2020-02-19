provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "my_security_group" {
  name        = "allow_dynamic_port"
  description = "My first security group"
  //vpc_id="${aws_vpc.}"
  dynamic "ingress" {
    for_each = ["1", "2", "3", "4", "5", "6"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


output "kk" {
  value = values(aws_security_group.my_security_group)
}
#output "get_id_vpc" {
#  value = aws_security_group.my_security_group.ingress.cidr_blocks
#}



//output "get_vpc" {
//  value = "aws_vpc.value.id"
//}
