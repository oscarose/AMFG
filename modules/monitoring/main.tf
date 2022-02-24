module "s3" {
  source = "../../modules/s3"
}

resource "aws_cloudtrail" "demo_tf_trail" {
    name = "tf_cloudtrail"
    enable_logging = var.enable_logging
    s3_bucket_name = module.s3.bucket_name
    enable_log_file_validation = var.enable_log_file_validation

    tags = {
        Name = "demo_tf_trail"
        Project = "dev_environment"
    }
}
