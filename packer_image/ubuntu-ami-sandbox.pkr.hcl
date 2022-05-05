packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "group4-wordpress-ami" {
  ami_name = "group4-wordpress-ami-${local.timestamp}"
  source_ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  region = "us-east-2"
  ssh_username = "ubuntu" 
  vpc_id = "vpc-0a97d40e17f411b25"
  subnet_id = "subnet-081d2eed40fc025ee"
}

build {
  sources = [
    "source.amazon-ebs.group4-wordpress-ami"
  ]

  provisioner "ansible" {
    playbook_file = "/Users/darryl.avery/challenge-weeks/AMI-Repo/ansible/challenge-final-playbook.yml"
  }
}


