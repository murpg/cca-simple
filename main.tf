provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "application" {
  name = "application"

  image              = "docker-16-04"
  region             = "nyc3"
  size               = "s-2vcpu-2gb"
  private_networking = true
  ssh_keys           = ["${var.ssh_key_fingerprint}"]

  # prepare folder structure
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /cca",
      "mkdir -p /cca/app",
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.ssh_private_key)}"
      user        = "root"
      timeout     = "2m"
    }
  }

  # copy coldbox application
  provisioner "file" {
    source      = "app/"
    destination = "/cca/app"

    connection {
      type        = "ssh"
      private_key = "${file(var.ssh_private_key)}"
      user        = "root"
      timeout     = "2m"
    }
  }

  # copy docker-compose config file
  provisioner "file" {
    source      = ".deployment/docker-compose.yml"
    destination = "/cca/docker-compose.yml"

    connection {
      type        = "ssh"
      private_key = "${file(var.ssh_private_key)}"
      user        = "root"
      timeout     = "2m"
    }
  }

  # start application
  provisioner "remote-exec" {
    inline = [
      "cd /cca",
      "docker-compose up -d > /dev/null 2>&1",
      "docker-compose ps",
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.ssh_private_key)}"
      user        = "root"
      timeout     = "2m"
    }
  }
}
