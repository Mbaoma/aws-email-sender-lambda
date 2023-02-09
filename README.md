# aws-email-sender-lambda

## Aim:
To automate the process of sending emails to an admin, whenever files are uploaded to an S3 bucket.

## AWS Services Used:
- AWS Lambda
- AWS S3 bucket
- AWS Simple Email Service (SES)

## Steps:
- create an S3 bucket using Terraform. 

- setup an IAM role and attach a policy to it. This is to give permission to Lambda, SES and our S3 bucket.

- register sender and receiver email addresses on AWS SES.

- define a lambda function that is triggered when a document is uploaded to the S3 bucket - this function sends an email to a specified email address.

# Replicate this task in your environment
```bash
$ terraform init
$ terraform validate
$ terraform plan
$ terraform apply
```

## Resources
- S3 Bucket
<img width="748" alt="image" src="https://user-images.githubusercontent.com/49791498/217707777-2b2507c0-2457-4bf0-ae08-04340357865a.png">

- AWS SES
<img width="749" alt="Screenshot 2023-02-09 at 04 09 46" src="https://user-images.githubusercontent.com/49791498/217708167-c872e1ff-cf90-4920-8c67-db24c518e042.png">

- Lambda function
<img width="1020" alt="image" src="https://user-images.githubusercontent.com/49791498/217708339-2c81ee2f-fda2-4b0f-b485-b0e761a4184f.png">

- End Result
File to upload
<img width="839" alt="image" src="https://user-images.githubusercontent.com/49791498/217709786-1288bebc-13bd-4c8c-bf25-95df6ed840db.png">

- Email sent upon successful file upload
<img width="1003" alt="image" src="https://user-images.githubusercontent.com/49791498/217710403-3e067276-07e4-4f88-926b-92b3a7bce6c5.png">

[Reference](https://www.workfall.com/learning/blog/send-s3-event-notification-email-using-lambda-and-ses/)
