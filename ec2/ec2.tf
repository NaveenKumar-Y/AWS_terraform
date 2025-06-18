data "aws_ami" "latest_amazon_linux" {
    most_recent = true
    filter {
      name =  "name"
      values = ["al2023-ami-*-kernel-6.1-x86_64"]
    }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "random_id" "unique_id" {
    byte_length = 4
}


resource "aws_instance" "my_instance" {
  ami = data.aws_ami.latest_amazon_linux.id
  # name = "my_ec2_instance"
  instance_type = "t2.micro"

  key_name = var.ssh_pulbic_key_name

  associate_public_ip_address = true
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = var.ec2_subnet_id

  user_data = file("${path.module}/startup-script.sh")

  monitoring = var.enable_monitoring

   

  tags= {
      name = "my_ec2_instance-${random_id.unique_id.hex}"
    }

}