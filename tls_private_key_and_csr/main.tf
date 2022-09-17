# Simple tls_private_key and tls_cert_request resources
# change the filename with your own path
# Before generate key with ssh-keygen -b 4096 -t RSA
# with output as /home/terraform/data/tls/tls_private_key_and_csr/private_key.pem
resource "local_file" "key_data" {
        filename       = "/home/terraform/data/tls/tls_private_key_and_csr/private_key.pem"
        content = tls_private_key.private_key.private_key_pem
        file_permission =  "0400"
}
resource "tls_private_key" "private_key" {
  algorithm   = "RSA"
  rsa_bits  = 4096
}
resource "tls_cert_request" "csr" {
  private_key_pem = file("/home/terraform/data/tls/tls_private_key_and_csr/private_key.pem")
  depends_on = [ local_file.key_data, tls_private_key.private_key ]
  
  subject {
    common_name  = "flexit.com"
    organization = "FlexIT Consulting Services"
  }
}