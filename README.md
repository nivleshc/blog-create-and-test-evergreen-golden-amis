# -blog-create-and-test-evergreen-golden-amis
This repository contains code for deploying a solution that will detect when a new base AMI has been released by AWS. If the detection is successful, a new golden AMI using the new base AMI will be built, and then automatically tested to confirm that it ready to be used in the deployment pipeline
