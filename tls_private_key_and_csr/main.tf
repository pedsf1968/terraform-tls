# Simple tls_private_key and tls_cert_request resources
# Before generate key with ssh-keygen -b 4096 -t RSA
# with output as ${path.module}/private_key.pem
resource "local_file" "key_data" {
        filename       = "${path.module}/private_key.pem"
        content = tls_private_key.private_key.private_key_pem
        file_permission =  "0400"
}
resource "tls_private_key" "private_key" {
  algorithm   = "RSA"
  rsa_bits  = 4096
}
resource "tls_cert_request" "csr" {
  private_key_pem = file("${path.module}/private_key.pem")
  depends_on = [ local_file.key_data, tls_private_key.private_key ]
  
  subject {
    common_name  = "flexit.com"
    organization = "FlexIT Consulting Services"
  }
}