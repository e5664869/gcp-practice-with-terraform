variable "gcp-project" {
  type = string
}
variable "provider-region" {
  type    = string
  default = "us-central1"
}
variable "vpc-name" {
  type    = string
  default = "my-custom-vpc"
}

variable "private-subnet-name" {
  type    = string
  default = "my-custom-subnet"
}
variable "private-subnet-region" {
  type    = list(string)
  default = ["us-central1", "us-east1"]
}
variable "private-subnet-cidir-range" {
  type    = list(string)
  default = ["10.10.10.0/24", "10.10.20.0/24"]
}
##################################################
variable "public-subnet-name" {
  type = string
}
variable "public-subnet-region" {
  type = list(string)
}
variable "public-subnet-cidir-range" {
  type = list(string)
}
variable "secondary_range" {
  type = list(object({
    range_name = string
    ip_range   = string
  }))
}
###################### Firewall############
variable "firewall_name" {
  type = string
}
################################### Compute Instance ########
variable "instance_name" {
  type = list(string)
}
variable "machine-type" {
  type = string
}
variable "service-account" {
  type = string
}
variable "instance-zone" {
  type = list(string)
}
variable "instance-image" {
  type = string
}
variable "instance-region" {
  type = list(string)
}