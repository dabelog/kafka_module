variable "environment" {
  type        = string
  description = "The Name  of Environment"
} //value comes from main.tf

variable "vpc_cidr" {}
variable "subnet_1" {}
variable "subnet_2" {}
variable "subnet_3" {}
variable "sg_name" {}
variable "cluster_name" {}
variable "kafka_version" {}
variable "number_of_broker_nodes" {
    type = number
}
