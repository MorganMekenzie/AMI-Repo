packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.9"
      source = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "challenge-image" {
  profile = "Cloudreach-TA-Lab"
  region = "us-east-1"
}

    provisioner "ansible" {
      playbook_file = "/Users/darryl.avery/challenge-weeks/AMI-Repo/ansible/ami-playbook.yml"
    }
}
