variable "vpc_cidr_block" {
    default = "vpc_cidr_block"
    type    = string

}
variable "public_subnets" {
    type    = list(string)
    default = ["subnet"]

}
variable "private_subnets" {
    type    = list(string)
    default = ["subnet"]
}
variable "instance_type" {
    type = string

}
variable "key_name" {
    type = string
}