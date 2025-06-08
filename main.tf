terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "/home/dronhead/tf-keys/authorized_key.json"
  folder_id                = "b1gjbtfobj69akrsh9gk"
  cloud_id                 = "ajeocujatq3iq74otb5u"
  zone = "ru-central1-b"
}

