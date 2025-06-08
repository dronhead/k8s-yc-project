variable "yc_token" {}
variable "yc_cloud_id" {}
variable "yc_folder_id" {}
variable "yc_zone" {
  default = "ru-central1-b"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}