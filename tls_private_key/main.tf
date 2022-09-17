# Simple tls_private_key resource
# change the filename with your own path

resource "tls_private_key" "pvtkey" {
   algorithm = "RSA"
   rsa_bits = 4096
}

resource "local_file" "key_details" {
  filename = "/home/terraform/data/tls/tls_private_key/key.txt"
  content = "${tls_private_key.pvtkey.private_key_pem}"
}
