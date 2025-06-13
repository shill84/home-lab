terraform {
  required_version = ">= 1.10.5"
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      # Due to a bug in the provider I'm using the RC version which fixes the kernel panic issue I was facing
      version = "3.0.1-rc8"
    }
  }
}

provider "proxmox" {
    pm_api_url   = var.api_url
    pm_api_token_id = var.proxmox_token_id
    pm_api_token_secret = var.proxmox_token_secret
    pm_tls_insecure = true
    pm_log_enable = true
    pm_log_file = "terraform-plugin-proxmox.log"
    pm_log_levels = {
      _default    = "debug"
      _capturelog = ""
    }
}

resource "proxmox_vm_qemu" "cloudinit-example" {
  vmid        = 500
  name        = "test-terraform0"
  target_node = var.proxmox_host
  agent       = 1
  cores       = 2
  memory      = 1024

  bios        = "ovmf"
  os_type     = "cloud-init"
  clone       = var.template_name
  vcpus       = 0
  cpu_type    = "host"
  scsihw      = "virtio-scsi-pci"

  ciuser      = "steve"
  cipassword  = "developer"
  sshkeys     = var.ssh_key

  ipconfig0   = "ip=dhcp,ip6=dhcp"
  skip_ipv6   = true

  cicustom = "vendor=local:snippets/vendor.yaml"

  serial {
    id = 0
    type = "socket"
  }

  # Setup the disk
  disks {
    scsi {
      scsi0 {
          cloudinit {
            storage = "local-lvm"
          }
      }
    }
    virtio {
      virtio0 {
        disk {
          size = "32G"
          storage = "local-lvm"
          discard  = true
        }
      }
    }
  }

  network {
    id = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}

output "proxmox_ip_address_default" {
  description = "Current IP Default"
  value = proxmox_vm_qemu.cloudinit-example.*.default_ipv4_address
}
