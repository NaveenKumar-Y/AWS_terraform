data "aws_elb_service_account" "main" {}

# resource "aws_s3_bucket" "elb_logs" {
#   bucket = "my-elb-tf-test-bucket"
# }

# resource "aws_s3_bucket_acl" "elb_logs_acl" {
#   bucket = aws_s3_bucket.elb_logs.id
#   acl    = "private"
# }

data "aws_iam_policy_document" "allow_elb_logging" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.main.arn]
    }

    actions   = ["s3:PutObject"]
    resources = ["${module.s3_for_asg.s3_arn}/*"] #/myapp-lb/myAWSLogs/
  }
}

resource "aws_s3_bucket_policy" "allow_elb_logging" {
  bucket = module.s3_for_asg.s3_bucket_id
  policy = data.aws_iam_policy_document.allow_elb_logging.json
}