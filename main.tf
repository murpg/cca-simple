provider "digitalocean" {
  token = "${var.do_token}"
}

data "template_file" "cca-docker-compose-file" {
  template = "${file("${path.module}/.deployment/docker-compose.yml.tpl")}"
}

resource "digitalocean_droplet" "application" {
  name = "cca-application-adobe2018"

  image              = "${var.droplet_image}"
  region             = "${var.droplet_region}"
  size               = "${var.droplet_size}"
  private_networking = true
  ssh_keys           = ["${var.ssh_key_fingerprint}"]

  # prepare folder structure
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /cca/app",
      "echo '${data.template_file.cca-docker-compose-file.rendered}' > /cca/docker-compose.yml",
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

  # start application
  provisioner "remote-exec" {
    inline = [
      "cd /cca",
      "docker-compose up -d > /dev/null 2>&1",
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.ssh_private_key)}"
      user        = "root"
      timeout     = "2m"
    }
  }
}

output "application_ip" {
  value = "${digitalocean_droplet.application.ipv4_address}"
}
