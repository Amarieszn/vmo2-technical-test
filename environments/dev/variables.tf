variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
  default     = "coherent-elf-429811-d7"
}

variable "region" {
  description = "The region to deploy to"
  type        = string
  default     = "europe-west2"
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
  default     = "hello-world"
}

variable "image" {
  description = "The container image to deploy"
  type        = string
  default     = "gcr.io/cloudrun/hello"
}

variable "invoker_member" {
  description = "The member to grant the invoker role"
  type        = string
  default     = "allUsers"
}
