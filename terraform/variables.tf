variable "username" {
  description = "The username for the database"
  type        = string
}

variable "password" {
  description = "The password for the database"
  type        = string
}

variable "postgres_version" {
  description = "The version of PostgreSQL to use"
  type        = string
  default     = "16.0"
}

variable "aws_resource_owner" {
  description = "The owner of the AWS resources"
  type        = string
  #   default     = "luke.bradford@bbd.co.za"
}

variable "rds_instance_identifier" {
  description = "The identifier for the RDS instance"
  type        = string

}
