provider "aws" {}

data "aws_availability_zones" "working" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

output "data_aws_availability_zone" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_availability_zone_0" {
  value = data.aws_availability_zones.working.names[0]
}

output "data_aws_availability_zone_1" {
  value = data.aws_availability_zones.working.names[1]
}

output "data_aws_caller_identity_1" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_caller_identity_2" {
  value = data.aws_caller_identity.current.user_id
}
output "data_aws_region_1" {
  value = data.aws_region.current.name
}

output "data_aws_region_1" {
  for_each = ["name", "description"]
  value    = data.aws_region.current.${each.value}

}

/*output "data_aws_region_2" {
  value = data.aws_region.current.description
}*/
