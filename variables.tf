variable "do_token" {
  description = "Your DigitalOcean Personal Access Token."
}

variable "ssh_key_fingerprint" {
  description = "Fingerprint of your SSH public key."
}

variable "ssh_private_key" {
  description = "Private SSH key location, so Terraform can connect to new droplets."
}

variable "droplet_image" {
  default     = "docker-16-04"
  description = "The Droplet image ID."
}

variable "droplet_region" {
  default     = "nyc3"
  description = " The region to start in."
}

variable "droplet_size" {
  default     = "s-2vcpu-4gb"
  description = "The instance size to start."
}

variable "admin_allowed_ip_list" {
  default     = ["127.0.0.1"]
  description = "List of allowed IPs for admin access. Default is '127.0.0.1' only."
  type        = "list"
}

variable "admin_password" {
  default     = "commandbox"
  description = "Plain text admin password. Default is 'commandbox'."
}
