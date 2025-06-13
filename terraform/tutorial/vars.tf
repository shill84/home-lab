variable "proxmox_token_id" {
  default = "terraform@pam!terraform01"
}

variable "proxmox_token_secret" {
  default = "5ab4d20c-069d-442a-8295-350b6434da69"
}

# Set your public SSH key here
variable "ssh_key" {
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPk2YG63BEtBNUCVxv5QXHfTsocTCyurBPD8n3hjnhS7 HillSt01@stepstone.com@UK-POR-MOB-3881"
}
# Set the Proxmox host here
variable "proxmox_host" {
    default = "pve1" 
}
# proxmox template name
variable "template_name" {
    default = "ubuntu-2404-cloudinit-template"
}
#Establish which nic you would like to utilize
variable "nic_name" {
    default = "vmbr0"
}
# Set the Proxmox API URL here
variable "api_url" {
    default = "https://192.168.2.68:8006/api2/json"
}

variable "vm_name" {
    default = "terraform-cloudinit-test"
}
# #Blank var for use by terraform.tfvars
# variable "token_secret" {
# }
# #Blank var for use by terraform.tfvars
# variable "token_id" {
# }