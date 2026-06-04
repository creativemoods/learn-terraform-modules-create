provider "aws" {
  region = "eu-south-2"

  default_tags {
    tags = {
      Training = "Terraform"
      Student  = "studentx"
    }
  }
}

module "website" {
  source = "./modules/aws-s3-static-website-bucket"

  # TODO Exercise 1: pass the required module input: bucket_name
  # TODO Exercise 1: pass tags to the module
  # TODO Exercise 4: override index_document and error_document
}
