provider "null" {}

variable "INTERNAL_SECRET" {
  default = "MRDIuSYR6wqg0ha9"
}

variable "OIDC_CLIENT_PWD" {
  default = "g3ize7GxYFPT"
}

resource "null_resource" "run_docker_container" {
  provisioner "local-exec" {
    command = "docker run --rm -e OIDC_CLIENT_PWD=${var.OIDC_CLIENT_PWD} -e INTERNAL_SECRET=${var.OIDC_CLIENT_PWD} iamprajwal007/crypt-encrypt:latest > encrypted_value.txt"
  }

  # Using the timestamp to trigger re-run on every apply
  triggers = {
    run_timestamp = timestamp()
  }
}

# Local file to capture the Docker output
data "local_file" "encrypted_value" {
  depends_on = [null_resource.run_docker_container]
  filename   = "${path.module}/encrypted_value.txt"
}

# Delete the file after extracting the value using another local-exec provisioner
resource "null_resource" "delete_file" {
  depends_on = [data.local_file.encrypted_value]

  provisioner "local-exec" {
    command = "rm -f encrypted_value.txt"
  }
    triggers = {
    run_timestamp = timestamp()
  }

}
# Define a local variable to store the value for reuse
locals {
  encrypted_value = trimspace(data.local_file.encrypted_value.content)
}

output "docker_encrypted_value" {
  value = local.encrypted_value
}

# # Example usage in another resource
# resource "aws_secretsmanager_secret" "example" {
#   name = "my-secret"
#   secret_string = local.encrypted_value  # Reusing the encrypted value here
# }