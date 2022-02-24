#locals {
#    enabled = module.sns.enabled

#    kms_key_id = local.enabled && var.encryption_enabled && var.kms_master_key_id != "" ? var.kms_master_key_id : ""
#}  

resource "aws_sns_topic" "demo_tf" {
    name = "demo_tf"
    kms_master_key_id = var.kms_key_id

    tags = {
        Name = "demo_tf_sns"
        Project = "dev_environment"
    }
}


resource "aws_sns_topic_subscription" "topic_email_subscription" {
    topic_arn = aws_sns_topic.demo_tf.arn
    protocol  = "email"
    endpoint  = "Abrahamdimma@gmail.com"
    endpoint_auto_confirms = "true"
}
