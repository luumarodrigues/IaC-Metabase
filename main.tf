resource "aws_key_pair" "KeyPair" {
  key_name   = "KeyPair"               # key pair name AWS
  public_key = "${file(var.public_key)}"
}

provider "aws" {
  region = var.region
}

# AMI AWS
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_security_group" "SecGroup" {
  name        = "SecGroup"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#  metabase port
  ingress {
  from_port   = 3000
  to_port     = 3000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  # HTTP access from the internet
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create instance
resource "aws_instance" "DevOps" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = var.instance_type
  key_name = "${aws_key_pair.KeyPair.id}"
  vpc_security_group_ids = ["${aws_security_group.SecGroup.id}"]
  monitoring = var.monitoring
  tags = var.tags
}

#install dependences and metabase
resource "null_resource" "provisioning" {
  triggers = {
    public_ip = "${aws_instance.DevOps.public_ip}"
  }

  connection {
    type        = "ssh"
    host        = "${aws_instance.DevOps.public_ip}"
    user        = "ubuntu"
    port        = 22
    private_key = "${file("${var.private_key}")}"
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install default-jdk",
      "wget http://downloads.metabase.com/v0.33.4/metabase.jar",
      "java -jar metabase.jar",
    ]
  }
}
