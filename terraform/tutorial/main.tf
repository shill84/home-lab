terraform {
  required_version = ">= 1.10.5"
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      # Due to a bug in the provider I'm using the RC version which fixes the kernel panic issue I was facing
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
    pm_api_url   = "https://192.168.2.68:8006/api2/json"
    pm_api_token_id = "terraform@pam!terraform01"
    pm_api_token_secret = "[token-from-doppler]"
    pm_tls_insecure = true
}


# TODO: Add network adaptor, VM creates but has no network access
resource "proxmox_vm_qemu" "my_vm" {
 name       = "my-vm"
 target_node = "pve1"
 clone      = "ubuntu-template"
 disk {
   type         = "disk"
   storage      = "local-lvm"
   size         = "20G"
   slot         = "scsi0"
 }
 cores      = 1
 memory     = 2048
}

