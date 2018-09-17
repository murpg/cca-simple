variable "do_token" {}
variable "ssh_key_fingerprint" {}
variable "ssh_private_key" {}
variable "ssh_public_key" {}

variable "droplet_image" {
  default     = "docker-16-04"
  description = "The Droplet image ID"
}

variable "droplet_region" {
  default     = "nyc3"
  description = " The region to start in"
}

variable "droplet_size" {
  default     = "s-2vcpu-4gb"
  description = "The instance size to start"
}

variable "admin_allowed_ip_address" {
  default     = "127.0.0.1"
  description = "Allowed IP address for admin access. Default is localhost only"
}
