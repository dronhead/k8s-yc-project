data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_vpc_network" "k8s_net" {
  name = "k8s-network"
}

resource "yandex_vpc_subnet" "k8s_subnet" {
  name           = "k8s-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.k8s_net.id
  v4_cidr_blocks = ["10.240.0.0/24"]
}

resource "yandex_compute_instance" "k8s_nodes" {
  count        = 4
  name         = "k8s-${count.index == 0 ? "master" : "worker-${count.index}"}"
  zone         = var.yc_zone
  platform_id  = "standard-v1"
  hostname     = "k8s-${count.index == 0 ? "master" : "worker-${count.index}"}"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.id
            size = 20
        }
    }

  network_interface {
    subnet_id      = yandex_vpc_subnet.k8s_subnet.id
    nat            = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
  }
}

output "external_ips" {
  value = {
    for instance in yandex_compute_instance.k8s_nodes : 
    instance.name => instance.network_interface[0].nat_ip_address}
}