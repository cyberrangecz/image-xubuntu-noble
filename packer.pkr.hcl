packer {
  required_plugins {
    openstack = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/openstack"
    }
  }
}

variable "short_sha" {
  type    = string
  default = env("TF_VAR_REV")
}

source "openstack" "xubuntu" {
  flavor              = "a1-2-20"
  image_name          = "xubuntu-noble-${var.short_sha}"
  insecure            = "true"
  source_image_name   = "ubuntu-noble-x86_64"
  ssh_username        = "ubuntu"
  image_visibility    = "public"
  floating_ip_network = "private-54"
  security_groups     = ["ansible-molecule"]
  networks            = ["b6b2cf9d-9e6d-42b8-a943-b17220e874ca"] #ansible-molecule  network
}

build {
  sources = ["source.openstack.xubuntu"]

  provisioner "shell" {
    scripts = [
      "scripts/desktop.sh",
      "scripts/vnc.sh",
      "scripts/vnccopypaste.sh",
      "scripts/cleanup.sh"
    ]
  }

  post-processor "shell-local" {
    command = join(" ", [
      "openstack image set xubuntu-noble-${var.short_sha} --insecure",
      "--property hw_scsi_model=virtio-scsi",
      "--property hw_disk_bus=scsi",
      "--property hw_rng_model=virtio",
      "--property hw_qemu_guest_agent=yes",
      "--property os_require_quiesce=yes",
      "--property os_type=linux",
      "--property os_distro=ubuntu",
      "--property owner_specified.openstack.version=${var.short_sha}",
      "--property owner_specified.openstack.gui_access=true",
      "--property owner_specified.openstack.custom=true"
    ])
  }
}
