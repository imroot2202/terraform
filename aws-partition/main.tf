/*locals {
  placeholder_json = <<EOT
{"country_iso":"US","key":"value"}
EOT
}

output "detected_country" {
  value = jsondecode(local.placeholder_json)["key"]
}
*/
data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request headers
  request_headers = {
    "Accept" = "application/json"
  }
}
output "some" {
  value = jsondecode(data.http.example.body)["project_website"]
}
