resource "tls_private_key" "ssh_keys" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


resource "local_file" "private_ssh_key" {
  content         = tls_private_key.ssh_keys.private_key_pem
  filename        = "${path.module}/ssh_key.pem"
  file_permission = "0600" # Set permissions to read/write for the owner only

}

resource "aws_key_pair" "key_pair" {
  key_name = "my_key_pair"
  # public_key = file("${path.module}/ssh_key.pem")
  public_key = tls_private_key.ssh_keys.public_key_openssh

}
