#IAM role for lambda
resource "aws_iam_role" "iam_lambda" {
  name = var.lambda_iam

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Create an S3 Bucket
resource "aws_s3_bucket" "unikbucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "unikbucket-acl" {
  bucket = aws_s3_bucket.unikbucket.id
  acl    = "private"
}

#Policy for AWS SES
resource "aws_iam_policy" "ses_policy" {
  name        = var.ses-policy
  path        = "/"
  description = var.ses-policy-description
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
        ]
        "Effect" : "Allow",
        "Resource" : "arn:aws:logs:*:*:*"
      },
      {
        "Action" : [
          "s3:GetObject",
        ]
        "Effect" : "Allow",
        "Resource" : "arn:aws:s3:::unikbucket567902889489ghfjkwlkskld/*"
      },
      {
        "Action" : [
          "ses:SendEmail",
          "ses:SendRawEmail",
        ]
        "Effect" : "Allow",
        "Resource" : "*"
      },
    ]
  })
}

#Attach the ses policy to lamda role created above
resource "aws_iam_role_policy_attachment" "attach-ses-lambda" {
  role       = aws_iam_role.iam_lambda.name
  policy_arn = aws_iam_policy.ses_policy.arn
}

# Setup your email(s) on AWS SES
resource "aws_ses_email_identity" "sender" {
  email = var.sender_email
}

resource "aws_ses_email_identity" "receiver" {
  email = var.receiver_email
}

#define lambda function
resource "aws_lambda_function" "email_lambda" {
  filename         = var.function_file
  function_name    = var.function_name
  role             = aws_iam_role.iam_lambda.arn
  source_code_hash = filebase64sha256("send_email_function.zip")
  runtime          = var.runtime
  handler          = var.handler
}

#define trigger
resource "aws_s3_bucket_notification" "lambda-trigger" {
  bucket = var.bucket_name
  lambda_function {
    lambda_function_arn = aws_lambda_function.email_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.email_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.unikbucket.id}"
}