variable "lambda_iam" {
  default = "iam_for_lambda"
}

variable "ses-policy" {
  default = "sampleSES"
}

variable "ses-policy-description" {
  default = "SES policy"
}

variable "bucket_name" {
  default = "uniket56790289gh"
}

variable "sender_email" {
  default = "mmaryraphaella@gmail.com"
}

variable "receiver_email" {
  default = "mchiomamaryraphaella@yahoo.com"
}

variable "function_file" {
  default = "send_email_function.zip"
}

variable "function_name" {
  default = "send_email_lambda"
}

variable "runtime" {
  default = "python3.9"
}

variable "handler" {
  default = "main.lambda_handler"
}