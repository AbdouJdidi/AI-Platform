variable "cluster_name" {
  type    = string
  default = "ai-platform"
}

variable "worker_count" {
  type    = number
  default = 2
}
variable "http_port" {
  type    = number
  default = 8090
}

variable "https_port" {
  type    = number
  default = 8453
}
