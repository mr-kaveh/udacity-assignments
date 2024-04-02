# udacity-assignments

# Project1: Data durability and recovery

In this project you will create highly available solutions to common use cases.  You will build a Multi-AvailabilityZone, Multi-Region database and show how to use it in multiple geographically separate AWS regions.  You will also build a website hosting solution that is versioned so that any data destruction and accidents can be quickly and easily undone.

## Project Instructions
### Cloud formation
In this project, you will use the AWS CloudFormation to create Virtual Private Clouds. CloudFormation is an AWS service that allows you to create "infrastructure as code". This allows you to define the infrastructure you'd like to create in code, just like you do with software. This has the benefits of being able to share your infrastructure in a common language, use source code control systems to version your infrastructure and allows for documenting and reviewing of infrastructure and infrastructure proposed changes.

CloudFormation allows you to use a configuration file written in a YAML file to automate the creation of AWS resources such as VPCs. In this project, you will use a pre-made CloudFormation template to get you started. This will allow you to create some of the infrastructure that you'll need without spending a lot of time learning details that are beyond the scope of this course.

You can find the YAML file in the GitHub repo: https://github.com/udacity/nd063-c2-design-for-availability-resilience-reliability-replacement-project-starter-template/blob/master/cloudformation/vpc.yaml

In order to build a VPC from the YAML file, follow the steps:

1. Services -> CloudFormation
2. Create stack “With new resources (standard)”
  ![Create VPC](screenshots/cloudformationCreate.png "Create VPC")
3. Template is ready
4. Upload a template file
5. Click “Choose file” button
6. Select provided YAML file
7. Next
8. Fill in Stack name
9. Name the VPC
10. Update the CIDR blocks
11. Click Next
12. Click Next again
13. Click Create stack
14. Wait for the stack to build out.  Refresh until status becomes “CREATE_COMPLETE”
15. Observe the “Outputs” tab for the created IDs.  These will be used later.

Once the CloudFormation Stack has completed, you can look at the "Resources" tab to see all of the AWS resources that the stack has created.  You can see both the type of resources that have been created, as well as the AWS identifiers for those resources so that you can locate these resources in the AWS service that they are a part of.

The "Outputs" tab shows you custom output from the CloudFormation Stack that is labeled and described for you.  These descriptions are custom descriptions that were added to the CloudFormation template and make it easier for you to find specific values that have been created as a part of the CloudFormation stack.  Here, you can find the VPC ID that has been created, the subnet IDs including which subnets are public and which are private, and the Security Groups that have been created and a description of each.

### Part 1
Complete the following steps:
### Data durability and recovery
In order to achieve the highest levels of durability and availability in AWS you must take advantage of multiple AWS regions. 
1. Pick two AWS regions. An active region and a standby region.
2. Use CloudFormation to create one VPC in each region. Name the VPC in the active region "Primary" and name the VPC in the standby region "Secondary".

**NOTE**: Be sure to use different CIDR address ranges for the VPCs.
**SAVE** screenshots of both VPCs after they are created. Name your screenshots: primary_Vpc.png, secondary_Vpc.png


### Highly durable RDS Database
1. Create a new RDS Subnet group in the active and standby region.
2. Create a new MySQL, multi-AZ database in the active region. The database must:
     - Be a “burstable” instance class.
     - Have only the “UDARR-Database” security group.
     - Have an initial database called “udacity.”
3. Create a read replica database in the standby region. This database has the same requirements as the database in the active region. 

**SAVE** screenshots of the configuration of the databases in the active and secondary region after they are created. 
**SAVE** screenshots of the configuration of the database subnet groups as well as route tables associated with those subnets. Name the screenshots: primaryDB_config.png, secondaryDB_config.png, primaryDB_subnetgroup.png, secondaryDB_subnetgroup.png, primaryVPC_subnets.png, secondaryVPC_subnets.png, primary_subnet_routing.png, secondary_subnet_routing.png


### Estimate availability of this configuration
Write a paragraph or two describing the achievable Recovery Time Objective (RTO) and Recovery Point Objective (RPO) for this Multi-AZ, multi-region database in terms of:

1. Minimum RTO for a single AZ outage
2. Minimum RTO for a single region outage
3. Minimum RPO for a single AZ outage
4. Minimum RPO for a single region outage

**SAVE** your answers in a text file named "estimates.txt"

### Demonstrate normal usage
In the active region:
1. Create an EC2 keypair in the region
2. Launch an Amazon Linux EC2 instance in the active region. Configure the instance to use the VPC's public subnet and security group ("UDARR-Application"). 
3. SSH to the instance and connect to the "udacity" database in the RDS instance. 
4. Verify that you can create a table, insert data, and read data from the database. 
5. You have now demonstrated that you can read and write to the primary database

**SAVE** the log of connecting to the database, creating the table, writing to and reading from the table in a text file called "log_primary.txt"

### Monitor database
1. Observe the “DB Connections” to the database and how this metric changes as you connect to the database
2. Observe the “Replication” configuration with your multi-region read replica. 

**SAVE** screenshots of the DB Connections and the database replication configuration. Name your screenshots: monitoring_connections.png, monitoring_replication.png

### Part 2
### Failover And Recovery
In the standby region:

1. Create an EC2 keypair in the region
2. Launch an Amazon Linux EC2 instance in the standby region. Configure the instance to use the VPC's public subnet and security group ("UDARR-Application").
3. SSH to the instance and connect to the read replica database.
4. Verify if you are not able to insert data into the database but are able to read from the database.
5. You have now demonstrated that you can only read from the read replica database.

**SAVE** log of connecting to the database, writing to and reading from the table in a text file called "log_rr_before_promotion.txt"

**SAVE** screenshot of the database configuration now, before promoting the read replica database in the next step. Name your screenshot: rr_before_promotion.png

6. Promote the read replica
7. Verify that if you are able to insert data into and read from the read replica database.
8. You have now demonstrated that you can read and write the promoted database in the standby region.

**SAVE** log of connecting to the database, writing to and reading from the database in a text file named "log_rr_after_promotion.txt"

**SAVE** screenshots of the database configuration after the database promotion. Name your screenshot: rr_after_promotion.png

### Part 3
### Website Resiliency

Build a resilient static web hosting solution in AWS. Create a versioned S3 bucket and configure it as a static website.

1. Enter “index.html” for both Index document and Error document
2. Upload the files from the GitHub repo (under `/project/s3/`)
3. Paste URL into a web browser to see your website. 

**Save** the screenshot of the webpage. Name your screenshot "s3_original.png"
You will now “accidentally” change the contents of the website such that it is no longer serving the correct content

You will now “accidentally” change the contents of the website such that it is no longer serving the correct content

1. Change `index.html` to refer to a different “season”
2. Re-upload `index.html`
3. Refresh web page

**SAVE** a screenshot of the modified webpage. Name your screenshot "s3_season.png"

You will now need to “recover” the website by rolling the content back to a previous version.

1. Recover the `index.html` object back to the original version
2. Refresh web page

**SAVE** a screenshot of the modified webpage. Name your screenshot "s3_season_revert.png"

You will now “accidentally” delete contents from the S3 bucket. Delete “winter.jpg”

**SAVE** screenshots of the modified webpage and of the existing versions of the file showing the "Deletion marker". Name your screenshots: s3_deletion.png, s3_delete_marker.png

You will now need to “recover” the object:

1. Recover the deleted object
2. Refresh web page

**SAVE** a screenshot of the modified webpage. Name your screenshot "s3_delete_revert.png"

# Project2: Design, Provision and Monitor AWS Infrastructure at Scale

### Part 1

You have been asked to plan and provision a cost-effective AWS infrastructure for a new social media application development project for 50,000 single-region users. The project requires the following AWS infrastructure and services:

-   Infrastructure in the following region:  `us-east-1`
-   A user/client machine
-   One VPC
-   Two Availability Zones
-   Four Subnets (2 Public, 2 Private)
-   A NAT Gateway
-   A CloudFront distribution with an S3 Bucket
-   Web servers in the Public Subnets
-   Application Servers in the Private Subnets
-   DB Servers in the Private Subnets
-   Web Servers are Load Balanced and Autoscaled
-   Application Servers are Load Balanced and Autoscaled
-   A Master DB in AZ 1 with a read replica in AZ2

#### Make sure to:

-   All services in the diagram include a label to indicate the type of service and any necessary parameters (e.g. size, location).
-   Use visible lines to represent all network connections
-   Use  [LucidChart(opens in a new tab)](https://www.lucidchart.com/)  or a similar diagramming application to create your schematic. There are icons for Auto Scaling and Application Load Balancer that you can use.
-   Set the server types based on the budget you have; therefore, label the servers after you finish the cost estimations.
-   Export your schematic as a PDF and save it as  `Udacity_Diagram_1.pdf`.

### Part 2

You have been asked to plan a SERVERLESS architecture schematic for a new application development project. The project requires the following AWS infrastructure and services.

-   A user/client machine
-   AWS Route 53
-   A CloudFront Distribution
-   AWS Cognito
-   AWS Lambda
-   API Gateway
-   DynamoDB
-   S3 Storage

#### Make sure to:

-   All services in the diagram include a label to indicate the type of service
-   Use visible lines to represent all network connections
-   Export your schematic as a PDF and save it as  `Udacity_Diagram_2.pdf`

# Project3: Secure the Recipe Vault Web Application

_**Deliverables for Exercise 1:**_

-   **E1T4.txt**  - Text file identifying 2 poor security practices with justification.

### Task 1: Review Architecture Diagram

In this task, the objective is to familiarize yourself with the starting architecture diagram. An architecture diagram has been provided which reflects the resources that will be deployed in your AWS account.

The diagram file, title  `AWS-WebServiceDiagram-v1-insecure.png`, can be found in the  _starter_  directory in  [this repo(opens in a new tab)](https://github.com/udacity/nd063-c3-design-for-security-project-starter).

![An image of Architecture Diagram of Project Environment](https://video.udacity-data.com/topher/2020/February/5e46ed35_aws-webservicediagram-v1-insecure/aws-webservicediagram-v1-insecure.png)

Architecture Diagram of Project Environment

#### Expected user flow:

-   Clients will invoke a public-facing web service to pull free recipes.
-   The web service is hosted by an HTTP load balancer listening on port 80.
-   The web service is forwarding requests to the web application instance which listens on port 5000.
-   The web application instance will, in turn, use the public-facing AWS API to pull recipe files from the S3 bucket hosting free recipes. An IAM role and policy will provide the web app instance permissions required to access objects in the S3 bucket.
-   Another S3 bucket is used as a vault to store secret recipes; there are privileged users who would need access to this bucket. The web application server does not need access to this bucket.

#### Attack flow:

-   Scripts simulating an attack will be run from a separate instance which is in an un-trusted subnet.
-   The scripts will attempt to break into the web application instance using the public IP and attempt to access data in the secret recipe S3 bucket.

### Task 2: Review CloudFormation Template

In this task, the objective is to familiarize yourself with the starter code and to get you up and running quickly. Spend a few minutes going through the .yml files in the  _starter_  folder to get a feel for how parts of the code will map to the components in the architecture diagram.

Additionally, we have provided a CloudFormation template which will deploy the following resources in AWS:

#### VPC Stack for the underlying network:

-   A VPC with 2 public subnets, one private subnet, and internet gateways etc for internet access.

#### S3 bucket stack:

-   2 S3 buckets that will contain data objects for the application.

#### Application stack:

-   An EC2 instance that will act as an external attacker from which we will test the ability of our environment to handle threats
-   An EC2 instance that will be running a simple web service.
-   Application LoadBalancer
-   Security groups
-   IAM role

### Task 3: Deployment of Initial Infrastructure

In this task, the objective is to deploy the CloudFormation stacks that will create the below environment.

![Diagram of CloudFormation infrastructure](https://video.udacity-data.com/topher/2020/February/5e46ed73_aws-webservicediagram-v1-insecure/aws-webservicediagram-v1-insecure.png)

Diagram of CloudFormation infrastructure

We will utilize the AWS CLI in this guide, however, you are welcome to use the AWS console to deploy the CloudFormation templates.

**0. Make sure that your IDE (preferably VS Code) is integrated with AWS.**

Follow the instructions on the page "Connect VS Code with AWS" in "Lesson 1: AWS Cloud Architect Program Introduction".

#### 1. From the root directory of the repository - execute the below command to deploy the templates.

##### Deploy the S3 buckets

`aws cloudformation create-stack --region us-east-1  --stack-name c3-s3 --template-body file://starter/c3-s3.yml`

Expected example output:

`{   "StackId":  "arn:aws:cloudformation:us-east-1:4363053XXXXXX:stack/c3-s3/70dfd370-2118-11ea-aea4-12d607a4fd1c"  }`

##### Deploy the VPC and Subnets

`aws cloudformation create-stack --region us-east-1  --stack-name c3-vpc --template-body file://starter/c3-vpc.yml`

Expected example output:

`{   "StackId":  "arn:aws:cloudformation:us-east-1:4363053XXXXXX:stack/c3-vpc/70dfd370-2118-11ea-aea4-12d607a4fd1c"  }`

##### Deploy the Application Stack

You will need to specify a pre-existing key-pair name. If you don't have a pre-existing key-pair, follow these steps below:

-   Launch AWS Console by clicking on  `Launch AWS Gateway`  followed by  `Open AWS Console`.
-   Go to the  `EC2 dashboard`, then under the  `Networking & Security`  to the  `Key Pairs`
-   Click on  `Key-pairs`  and then click on  `Create key pair`  on the top right.
-   Enter  `Name`, select  `pem`  file format and then click on  `Create key pair`  on the bottom right.

> Note - Your key's region must exist in the same region that you plan to deploy your stack.

`aws cloudformation create-stack --region us-east-1  --stack-name c3-app --template-body file://starter/c3-app.yml --parameters ParameterKey=KeyPair,ParameterValue=<add your key pair name here> --capabilities CAPABILITY_IAM`

> Note - If you created a key called  `create-stack-key.pem`, then you should replace  `<add your key pair name here>`  with  `create-stack-key`  - without the extension

Expected example output:

`{   "StackId":  "arn:aws:cloudformation:us-east-1:4363053XXXXXX:stack/c3-app/70dfd370-2118-11ea-aea4-12d607a4fd1c"  }`

Expected example AWS Console status:  [https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks(opens in a new tab)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks)

![A screenshot of successful CloudFormation infrastructure in AWS Portal](https://video.udacity-data.com/topher/2024/February/65cdd2bf_2024-02-15-10_00_40-stacks-_-cloudformation-_-us-east-1/2024-02-15-10_00_40-stacks-_-cloudformation-_-us-east-1.jpeg)

Successful CloudFormation Infrastructure

#### 2. Once you see Status is CREATE_COMPLETE for all 3 stacks, obtain the required parameters needed for the project.

Obtain the name of the S3 bucket by navigating to the Outputs section of the stack:

![Image of Obtain the name of the S3 bucket by navigating to the Outputs section of the stack:](https://video.udacity-data.com/topher/2024/February/65cdd311_2024-02-15-10_01_20-cloudformation-stack-c3-s3/2024-02-15-10_01_20-cloudformation-stack-c3-s3.jpeg)

Note down the names of the two other buckets that have been created, one for free recipes and one for secret recipes. You will need the bucket names to upload example recipe data to the buckets and to run the attack scripts.

-   You will need the Application Load Balancer endpoint to test the web service - ApplicationURL
-   You will need the web application EC2 instance public IP address to simulate the attack - ApplicationInstanceIP
-   You will need the public IP address of the attack instance from which to run the attack scripts - AttackInstanceIP

You can get these from the Outputs section of the  **c3-app**  stack.

![Image of the name of the buckets in the outputs section of the c3-app stack](https://video.udacity-data.com/topher/2024/February/65cdd32a_2024-02-15-10_02_26-cloudformation-stack-c3-s3/2024-02-15-10_02_26-cloudformation-stack-c3-s3.jpeg)

#### 3. Upload data to S3 buckets

Upload the free recipes to the free recipe S3 bucket from step 2. Do this by typing this command into the console (you will replace  `<BucketNameRecipesFree>`  with your bucket name):

Example:

`aws s3 cp free_recipe.txt s3://<BucketNameRecipesFree>/  --region us-east-1`

Upload the secret recipes to the secret recipe S3 bucket from step 2. Do this by typing this command into the console (you will replace  `<BucketNameRecipesSecret>`  with your bucket name):

Example:

`aws s3 cp secret_recipe.txt s3://<BucketNameRecipesSecret>/  --region us-east-1`

#### 4. Test the application

Invoke the web service using the application load balancer URL:

`http://<ApplicationURL>/free_recipe`

You should receive a recipe for banana bread.

The AMIs specified in the cloud formation template exist in the us-east-1 (N. Virginia) region. You will need to set this as your default region when deploying resources for this project.

### Task 4: Identify Bad Practices

Based on the architecture diagram, and the steps you have taken so far to upload data and access the application web service, identify at least 2 obvious poor practices as it relates to security. List these 2 practices, and a justification for your choices, in the text file named E1T4.txt.

**Deliverables:**

-   **E1T4.txt**  - Text file identifying 2 poor security practices with justification.

