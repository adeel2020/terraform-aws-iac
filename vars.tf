variable "AWS_REGION" {
    default = "us-east-1"
}
variable "ami" {
  type = map
  default = {
    us-east-1 = "ami-067d1e60475437da2"
    us-east-2 = "ami-0aec300fa613b1c92"
  }
}
variable "instance_count" {
  default = "1  "
}
variable "dbpass" {
  default = "admin123"
}
variable "dbname" {
  default = "accounts"
}
variable "USERNAME" {
  default = "ubuntu"
}
variable "rmquser" {
  default = "rabbit"
}
variable "rmqpass" {
  default = "pass123"
}
variable "MY-IP" {
  default = "91.73.5.40/32"
}
variable "PubKey" {
  default = "terraprokey.pub"
}
variable "PrivKey" {
  default = "terraprokey"
}
variable "zone1" {
  default = "us-east-1a"
}
variable "zone2" {
  default = "us-east-1b"
}
variable "zone3" {
  default = "us-east-1c"
}
variable "VPC-Name" {
  default = "TerraformVPC"
}
variable "VpcCIDR" {
  default = "172.21.0.0/16"
}
variable "pubsub1" {
  default = "172.21.1.0/24"
}
variable "pubsub2" {
  default = "172.21.2.0/24"
}
variable "pubsub3" {
  default = "172.21.3.0/24"
}
variable "privsub1" {
  default = "172.21.4.0/24"
}
variable "privsub2" {
  default = "172.21.5.0/24"
}
variable "privsub3" {
  default = "172.21.6.0/24"
}