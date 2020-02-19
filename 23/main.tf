provider "aws" {
  region = "eu-west-1"
}
variable "aws_users" {
  description = "List of AIM users to create"
  default     = ["Vasiliy", "Papik"]
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}
output "created_users" {
  value = aws_iam_user.users
}
output "created_users_ids" {
  value = aws_iam_user.users[*].unique_id
}
output "created_users_customs" {
  value = [
    for USER in aws_iam_user.users :
    "Username: ${USER.name} has ARN: ${USER.arn} and UNQUE_ID: ${USER.unique_id}"
  ]
}
#---------------------

resource "aws_instance" "test2" {
  count         = 2
  ami           = "ami-0c096a0f828d9ecf3"
  instance_type = "t2.micro"
  tags = {
    Name = "Server number ${count.index + 1}"
  }
}
output "server_all" {
  value = {
    for server in aws_instance.test2 :
    server.id => server.public_ip
  }
}
