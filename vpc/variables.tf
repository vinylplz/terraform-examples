variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "zone" {
  default = { 
    a = "us-east-1a"
    b = "us-east-1c"
  } 
}
