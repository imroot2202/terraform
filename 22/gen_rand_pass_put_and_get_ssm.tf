provider "aws" {
  region = "eu-west-1"
}

variable "environment" {
  default = "test"
  //  staging    = "staging"
  //  production = "production"
}
variable "to_change_passwd" {
  default = "STRING2"
}

resource "random_string" "gen_passwd" {
  length           = 20
  special          = true
  override_special = "/"
  keepers = {
    keeper1 = var.to_change_passwd
  }
}

resource "aws_ssm_parameter" "secret" {
  name        = "/${var.environment}/database/passwords/DB_1"
  description = "Master pwd for my test server"
  type        = "SecureString"
  value       = random_string.gen_passwd.result
  tags = {
    environment = "${var.environment}"
  }
}

data "aws_ssm_parameter" "get_password" {
  name       = "/${var.environment}/database/passwords/DB_1"
  depends_on = [aws_ssm_parameter.secret]
}

resource "aws_db_instance" "default" {
  identifier           = "${var.environment}"
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "Artem"
  password             = data.aws_ssm_parameter.get_password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
  depends_on           = [aws_ssm_parameter.secret]
}

output "get_password" {
  value = data.aws_ssm_parameter.get_password.value
}
//output "get_region"{
//  value =
//}
