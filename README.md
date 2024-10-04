# docker-nginx-https-terraform-aws-setup

## ON console.aws.amazon.com ##
#### Create S3 bucket and DynamoDB table ####
1. Create an S3 bucket. Take note of the S3 bucket name and ARN. Below referred to as S3-BUCKET-NAME and S3-RESOURCE-ARN. 
2. Create a DynamoDB table with partition key: "LockID". Take note of the S3 bucket name and ARN. Below referred to as DYNAMODB-TABLE-NAME and DYNAMODB-RESOURCE-ARN.
3. Create(allocate) an Elastic IP. Take note of the allocation ID, below referred to as ALLOCATION-ID.


## On Local Machine w/ Terraform and AWS CLI installed ##
#### FILL IN PARAMS: RESOURCE NAME & ARNs ####
Specify dynamodb_table and role-arn for backend s3 with S3-BUCKET-NAME and DYNAMODB-TABLE-NAME.</br>
- main.tf </br>
Specify S3 and DynamoDB ARNs with S3-RESOURCE-ARN and DYNAMODB-RESOURCE-ARN. </br>
- IAM-policy-for-role-to-assume JSON file

## ON console.aws.amazon.com ##
#### Create IAM Policy and Role ####
1. Create custom IAM Policy that allows access to the above s3 and dynamodb resources with the IAM-policy-for-role-to-assume JSON file.
2. Create an IAM Role with above policy. Take note of the IAM Role ARN, below referred to as IAM-ROLE-ARN.


## On Local Machine ##
#### FILL IN PARAMS: ARNs ####
Specify allocation_id for aws_eip_association with ALLOCATION-ID. </br>
Specify role_arn for assume_role with IAM-ROLE-ARN. </br>
- main.tf </br>

#### SPIN UP AWS EC2 RESOURCE ####
terraform init <br/>
terraform apply

## ON console.aws.amazon.com ##
#### Verify Everything is Working ####
- S3 bucket has a new directory: /your/path/to/key/
- DynamoDB table has 1 new item.
- EC2 instance is up and you can access it via the public AWS Elastic IP address.# aws-terraform-remote-state-locking-elastic-IP
