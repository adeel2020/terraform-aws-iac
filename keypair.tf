resource "aws_key_pair" "PubKey" {
  key_name   = "PubKey"
  public_key = file(var.PubKey)
}
 