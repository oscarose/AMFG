resource "aws_s3_bucket" "demo_tf_bucket" {
    bucket        = "ogba-tf-test-trail"
    #acl = "private"
    force_destroy = true

      policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::ogba-tf-test-trail"
        },
        {
            "Sid": "AWSCloudTrailWrite20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::ogba-tf-test-trail/AWSLogs/187212085277/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control",
                    "AWS:SourceArn": "arn:aws:cloudtrail:us-east-1:187212085277:trail/tf_cloudtrail"
                }
            }
        }
    ]
}
POLICY
}

