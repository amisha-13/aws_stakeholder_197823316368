provider "aws" {
    region = var.awsregion 
}

module "ec2_instance_linux" {
    source = "git::https://github.com/amisha-13/tf_aws_modules.git//module/ec2?ref=v1.3"
    instance_type = var.instancetype
    instance_count  = var.instancecount
    aws_region = var.awsregion
    
}

module "vpc" {
  source = "git::https://github.com/amisha-13/tf_aws_modules.git//module/vpc?ref=v1.3"

  env             = "dev"
  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"]

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/dev-demo"  = "owned"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb"         = 1
    "kubernetes.io/cluster/dev-demo" = "owned"
  }
}