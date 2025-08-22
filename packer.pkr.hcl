packer {
  required_plugins {
    openstack = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/openstack"
    }
  }
}

source "openstack" "image" {
  flavor              = "a4-4-35"
  image_name          = "xubuntu-noble"
  insecure            = "true"
  source_image_name   = "ubuntu-noble-x86_64"
  ssh_username        = "ubuntu"
  image_visibility    = "public"
  floating_ip_network = "private-54"
  security_groups     = ["ansible-molecule"]
  networks            = ["b6b2cf9d-9e6d-42b8-a943-b17220e874ca"] #ansible-molecule  network
}

build {
  sources = ["source.openstack.image"]

  provisioner "shell" {
    scripts = [
      "scripts/desktop.sh",
      "scripts/vnc.sh",
      "scripts/vnccopypaste.sh",
      "scripts/cleanup.sh"
    ]
  }
}
