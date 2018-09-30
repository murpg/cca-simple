# cca-simple

> A simple CCA (ColdBox Cloud Application) template

## Prerequisites

### Digital Ocean Account
Go to this [link](https://cloud.digitalocean.com/registrations/new) to sign up and create an account on Digital Ocean.  

### Download Terraform  
Go to this [link](https://www.terraform.io/downloads.html) and download the Terraform Binary and place it on your path. 

### Digital Ocean API Token

Generate a Personal Access Token via the DigitalOcean control panel. Instructions to do that can be found in this
[link](https://www.digitalocean.com/docs/api/create-personal-access-token/). Terraform will use this token to authenticate
to the DigitalOcean API, and control your account.

### SSH Key for Digital Ocean

To use SSH keys with your Droplets, you need to create an SSH key and import your SSH public key into DigitalOcean.
Follow this [tutorial](https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/) to do it.

### Clone Git Project 
`git clone git@github.com:murpg/cca-simple.git` Clone the git project and run box install inside the /cca-simple/app folder this will pull all of your dependencies. If you do not know how to run box install it means you are not using CommandBox. You can go to this [tutorial](https://commandbox.ortusbooks.com/getting-started-guide) to learn how to use CommandBox.  

## Variable Configuration

Terraform allows you to override variables used for  deployments. Copy `terraform.tfvars.sample` to `terraform.tfvars`
file and adjust variables or comment with a hash mark (#).

### Parameters

- `admin_allowed_ip_list`: An Array of a list of strings for allowed IPs that can get admin access. `["127.0.0.1", "0.0.0.0"]`
- `admin_password`: Plain text admin password.
- `do_token`: **required** Your DigitalOcean Personal Access Token.
- `droplet_image`: The Droplet image ID.
- `droplet_region`: The region to start in.
- `droplet_size`: The instance size to start.
- `ssh_key_fingerprint`: **required** Fingerprint of your SSH public key.
- `ssh_private_key`: **required** Private SSH key location, so Terraform can connect to new droplets.

#### Environment variables and default values

| CLI option                 | Environment variable              | Default                       |
| -------------------------- | --------------------------------- | ----------------------------- |
| `admin_allowed_ip_list`    | `TF_VAR_admin_allowed_ip_list`    | `["127.0.0.1"]`               |
| `admin_password`           | `TF_VAR_admin_password`           | `commandbox`                  |
| **`do_token`**             | `TF_VAR_do_token`                 | -                             |
| `droplet_image`            | `TF_VAR_droplet_image`            | `docker-16-04`                |
| `droplet_region`           | `TF_VAR_droplet_region`           | `nyc3`                        |
| `droplet_size`             | `TF_VAR_droplet_size`             | `s-2vcpu-4gb`                 |
| **`ssh_key_fingerprint`**  | `TF_VAR_ssh_key_fingerprint`      | -                             |
| **`ssh_private_key`**      | `TF_VAR_ssh_private_key`          | -                             |

## Managing the Deployment Lifecycle

Terraform makes it possible to create and destroy your ColdBox application in the cloud. First, initialize Terraform
for the project. This will read all configuration files and install needed plugins.

```bash
$ terraform init
```

>
> You can check the correctness of your code (e.g. missing values for variables) with:
>
> ```bash
> $ terraform validate
> ```
>

### Creating the application

To build your infrastructure and deploy your ColdBox application on DigitalOcean just run.

```bash
$ terraform apply
```

### Destroying the application

One of the amazing things about CCA application is that it handles the entire lifecycle of the stack. You can easily
destroy what you have built by running one simple Terraform command (destroy).

```bash
$ terraform destroy
```
