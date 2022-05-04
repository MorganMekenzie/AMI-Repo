packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "challengeweektest3" {
  ami_name = "final-ami-test-3"
  source_ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  region = "us-east-2"
  ssh_username = "ubuntu" 
  vpc_id = "vpc-0a97d40e17f411b25"
  subnet_id = "subnet-081d2eed40fc025ee"
}

build {
  sources = [
    "source.amazon-ebs.challengeweektest3"
  ]

  provisioner "ansible" {
    playbook_file = "/Users/darryl.avery/challenge-weeks/AMI-Repo/ansible/challenge-final-playbook.yml"
  }
}
