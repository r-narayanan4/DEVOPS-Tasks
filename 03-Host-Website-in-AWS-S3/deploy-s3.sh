#!/bin/bash

# Prompt for AWS credentials
aws configure

# Prompt for the desired bucket name and region
read -p "Enter your desired bucket name: " BUCKET_NAME
REGION="us-east-1"

# Check if the bucket already exists
if aws s3 ls "s3://$BUCKET_NAME" 2>&1 | grep -q 'NoSuchBucket'
then
  # Create the bucket if it does not exist
  aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION"

  # Upload index.html and styles.css to the bucket
  aws s3 cp index.html "s3://$BUCKET_NAME/index.html"
  aws s3 cp styles.css "s3://$BUCKET_NAME/styles.css"

  # Turn off block public access for the bucket
  aws s3api put-public-access-block --bucket "${BUCKET_NAME}" --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

  # Configure the bucket as a static website
  aws s3 website "s3://$BUCKET_NAME" --index-document index.html --error-document error.html

  # Apply bucket policy to allow public read access
  cat <<EOF > policy.json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
      },
      {
        "Sid": "AllowBucketPolicy",
        "Effect": "Allow",
        "Action": "s3:PutBucketPolicy",
        "Principal": {
          "AWS": "*"
        },
        "Resource": "arn:aws:s3:::$BUCKET_NAME"
      }
    ]
  }
  EOF

  # Apply the bucket policy
  aws s3api put-bucket-policy --bucket "$BUCKET_NAME" --policy file://policy.json

  # Print the URL of the static website
  echo "Your static website URL: http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
else
  # Prompt the user to enter another name if the bucket already exists
  read -p "Bucket already exists. Enter another name: " BUCKET_NAME
fi
