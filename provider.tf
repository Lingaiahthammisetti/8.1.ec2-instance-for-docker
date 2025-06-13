terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3" {
    bucket = "roboshop-docker-remote-state"
    key    = "roboshop-docker-key"
    region = "us-east-1"
    dynamodb_table = "roboshop-docker-locking"
    }
  }
provider "aws" {
  # Configuration options
  region = "us-east-1"
}