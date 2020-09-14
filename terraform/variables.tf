variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable "private_key_path" {
  # Описание переменной
  description = "Path to the private key used for connection provisioner"
}
variable zone {
  description = "Zone for VM"
  default     = "europe-west1-d"
}
variable ncount {
  description = "Count for VM"
  default     = "1"
}
