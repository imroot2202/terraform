provider "aws" {
  region = "eu-west-1"
  alias  = "Default"
}
provider "aws" {
  region = "ca-central-1"
  alias  = "Canada"
}
provider "aws" {
  region = "eu-central-1"
  alias  = "Germany"
}

#####################################
data "aws_ami" "Default_latest_ubuntu" {
  provider    = aws.Default
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-18.04-amd64*"]
  }
}

data "aws_ami" "canada_latest_ubuntu" {
  provider    = aws.Canada
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-18.04-amd64*"]
  }
}

data "aws_ami" "Germany_latest_ubuntu" {
  provider    = aws.Germany
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-18.04-amd64*"]
  }
}

output "show_data_CA" {
  value = data.aws_ami.canada_latest_ubuntu.id
}
output "show_data_GE" {
  value = data.aws_ami.Germany_latest_ubuntu.id
}
output "show_data_Def" {
  value = data.aws_ami.Default_latest_ubuntu.id
}

resource "aws_instance" "my_default-server" {
  instance_type = "t2.micro"
  ami           = "ami-0713f98de93617bb4"
  tags = {
    Name = "Default server"
  }
}

resource "aws_instance" "my_CANADA-server" {
  provider      = aws.Canada
  instance_type = "t2.micro"
  ami           = data.aws_ami.canada_latest_ubuntu.id
  tags = {
    Name = "CANADA server"
  }
}
resource "aws_instance" "my_Germany-server" {
  provider      = aws.Germany
  instance_type = "t2.micro"
  ami           = data.aws_ami.Germany_latest_ubuntu.id
  tags = {
    Name = "Germany server"
  }
}
