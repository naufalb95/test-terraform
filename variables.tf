variable "instance_name" {
  description = "Value of the Name tag in EC2 instance"
  type        = string
  default     = "NaufalEC2Instance"
}

variable "aws_region" {
  description = "Region for AWS"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr_block" {
  description = "CIDR Block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "main_subnet_cidr_block" {
  description = "Main Subnet CIDR Block for VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "secondary_subnet_cidr_block" {
  description = "Secondary Subnet CIDR Block for VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "rds_allocated_storage" {
  description = "Allocated Database Storage for RDS"
  type        = number
  default     = 10
}

variable "rds_db_name" {
  description = "DB Name for RDS"
  type        = string
  default     = "postgres"
}

variable "rds_storage_type" {
  description = "RDS Storage Type"
  type        = string
  default     = "gp2"
}

variable "rds_engine" {
  description = "RDS DB Engine"
  type        = string
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "RDS DB Engine Version"
  type        = string
  default     = "14.5"
}

variable "rds_instance_class" {
  description = "RDS Instance Class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_username" {
  description = "RDS DB UserName"
  type        = string
  default     = "postgres"
  sensitive   = true
}

variable "rds_password" {
  description = "RDS DB Password"
  type        = string
  default     = "postgres"
  sensitive   = true
}