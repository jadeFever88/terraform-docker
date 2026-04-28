variable "container_name" {
  description = "Назва нашого контейнера"
  type        = string
  default     = "Terraform_Nginx_Container"
}

variable "external_port" {
  type    = number
  default = 8080
}
