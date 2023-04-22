variable "access_key" {}
variable "secret_key" {}

data "aws_region" "current" {}

locals {
  vpc_name = "aws_test"
  vpc_id = "10.0.0.0/16"

  subnet = {
    public = {
      a = "10.0.10.0/25"
      c = "10.0.10.128/25"
    }
    protect = {
      a = "10.0.20.0/25"
      c = "10.0.20.128/25"
    }
    private = {
      a = "10.0.30.0/25"
      c = "10.0.30.128/25"
    }
    availability_zone = {
      a = "ap-northeast-1a"
      c = "ap-northeast-1c"
    }
  }
}