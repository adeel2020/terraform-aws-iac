terraform {
  backend "s3" {
    bucket = "terraform-blobstore"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}