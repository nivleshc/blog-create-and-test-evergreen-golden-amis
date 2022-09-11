# Using AWS CodePipeline, AWS CodeCommit, AWS CodeBuild, Packer and Chef Inspec to automatically build and test your Golden AMI
This repository contains code for deploying a solution that will automatically create golden AMIs when a new base AMI (Amazon Linux 2) is released by AWS. The golden AMI will be automatically tested using Chef Inspec.

The solution is written using an AWS Serverless Application Model (AWS SAM) template.  

It uses the following AWS services:
- AWS CodeCommit
- AWS CodeBuild
- AWS CodePipeline
- Amazon Simple Notification Service
- AWS Systems Manager Parameter Store
- AWS Lambda
- Amazon EventBridge

It also uses:
- Packer by HashiCorp, to build the golden AMI (https://www.packer.io/)
- Chef Inspec to test the golden AMI (https://docs.chef.io/inspec/)

The AWS Lambda function is written in Python 3.7.  


Detailed information about this solution is available at https://nivleshc.wordpress.com/2022/09/11/using-aws-codepipeline-aws-codecommit-aws-codebuild-packer-and-chef-inspec-to-automatically-build-and-test-your-golden-ami/
## Preparation
Clone this repository using the following command.
```
git clone https://github.com/nivleshc/blog-create-evergreen-golden-amis.git
```
Update the Makefile with appropriate values for the following:  
**aws_profile** - this should be set to the AWS profile that you have configured locally to provision resources into your AWS Account

**aws_s3_bucket** – this Amazon S3 bucket will be used by AWS SAM to store artefacts for the AWS CloudFormation stack that it will create. This Amazon S3 bucket must exist.

**PROJECT_NAME** - give a meaningful name for your project. Do not include any spaces. This name will be used to prefix the resources that are created so that their name is unique.

**EMAIL_FOR_NOTIFICATIONS** - provide an email address to which notifications from the AWS CodeBuild project will be sent to. Ensure you have access to this email address since AWS will send a confirmation email containing a link that needs to be clicked on. Also, important notifications regarding the build process will also be sent to it.

**VPCID** - this is the id of the Amazon Virtual Private Cloud (AWS VPC) where Packer will create the temporary Amazon EC2 instance, from which the golden ami will be created. The default subnet in this AWS VPC must be a public subnet since the AWS CodeBuild servers will connect to  the Amazon EC2 instance deployed in it via SSH. For simplicity, I used the default VPC. If you choose to use a different VPC, you can update the packer template file to add subnet_id and provide the id of your public subnet. You can read more about it here https://www.packer.io/plugins/builders/amazon/ebs#subnet_id

**CODEPIPELINE_ARTIFACTSTORE_S3_BUCKET** - this is the Amazon S3 bucket where the AWS CodePipeine pipeline will store its artifacts. For simplicity, make this Amazon S3 bucket different to the aws_s3_bucket defined earlier.

**TEST_SUBNET_ID** - this is the id of the subnet into which the test Amazon EC2 instance should be deployed.

**TEST_SECURITY_GROUP_ID** - this is the id of the security group that should be attached to the test Amazon EC2 instance. At a minimum, this security group doesn’t require any inbound rules. It just requires all outbound traffic to be allowed.

**TEST_EC2_INSTANCE_PROFILE** - this is the name of the IAM instance profile that should be attached to the test Amazon EC2 instance. This instance profile must grant the test Amazon EC2 permissions to upload objects to the CODEPIPELINE_ARTIFACTSTORE_S3_BUCKET. For reference, the Chef Inspec reports will be uploaded to this Amazon S3 bucket, inside the /tests folder.

For simplicity, leave the rest of the variables in the Makefile as they are.


## Commands
For help, run the following command:
```
make
```
To deploy the solution into your own AWS account, use the following steps:

```
make package
make deploy
```

If you make any changes to **template.yaml**, use the following command to deploy these changes to your AWS Account:
```
make update
```

To delete all resources that were provisioned by this solution in your AWS Account, run the following command. At the prompt, press CTRL+C to abort otherwise any other key to continue with the deletion.
```
make delete
```

## Post-Deployment
After you have successfully deployed the solution into your AWS Account, follow the instructions in the **Implementation** section of the above mentioned blog (https://nivleshc.wordpress.com/2022/09/11/using-aws-codepipeline-aws-codecommit-aws-codebuild-packer-and-chef-inspec-to-automatically-build-and-test-your-golden-ami/), to commit the files needed by the AWS CodeBuild projects into the AWS CodeCommit repository. This will automatically trigger the AWS CodePipeline pipeline and start the golden AMI build and test process.