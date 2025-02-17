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
    pm_api_token_secret = "Your token"
    pm_tls_insecure = true
}


# TODO: rebuild template image with ssh key regen service added to it
resource "proxmox_vm_qemu" "my_vm" {
 name       = "my-vm" # Name of the VM
 target_node = "pve1" # Node where the VM will be created
 clone      = "ubuntu-template" # Clone's a pre-existing template manually created in Proxmox
 cores      = 1 # Number of cores
 memory     = 2048 # Memory in MB
 agent      = 1 # Enable Qemu Guest Agent
 agent_timeout = 60 # Timeout for the Qemu Guest Agent
 # setups the disk configuration
 disk {
   type         = "disk" 
   storage      = "local-lvm"
   size         = "20G"
   slot         = "scsi0"
 }
 # setups the network configuration
 network {
   id         = 0
   bridge     = "vmbr0"
   firewall   = false
   link_down  = false
   model      = "virtio"
  }
}

output "proxmox_ip_address_default" {
  description = "Current IP Default"
  value = proxmox_vm_qemu.my_vm.*.default_ipv4_address
}
