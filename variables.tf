variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "eu-west-1"
}
variable "ami" {
  # Ubuntu 22.04, HVM, SSD
  default = "ami-00aa9d3df94c6c354"
}
variable "instanceType" {
  default = "t2.micro"
}

variable "username" {
  default = "ubuntu"
}
variable "ami_key_pair_name" {
  type = string
}
variable "keyPath" {
  type = string
}