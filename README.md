# terraform-modules
In this repo we will see about terraform modules and resource creation.

## Modules 

Modules are the collection of resources templates which are required  to create a solution

In our previous repo, We shall how to create the VPC there we had so many resources like VPC, Public, private subnets, IGW, Public Route tables, NAT gateways, Private Route Tables, EIP creation for NAT Gateway, Security Groups.
We all created manually by defining the resources one by one ourselves

But Modules will help us in creating the resource ( VPC, EC2 etc )  in easy way .
Module comes with inbuilt reference for all those resources which we created earlier manually.
We simply need to import the module and customize the resources on our requirement.


### Official Definition:
A module in Terraform is simply a collection of .tf files (resources, variables, outputs, etc.) that are grouped together to reuse code.

### Types

  1. Root Module
       Your current working directory where you have all configuration files [.tf] and you will apply the init, plan , apply.

  2. Child Module
       These are pre built functions/configuration .
       Which are called from root module when required.

      Types:
        Local : A directory inside your project itself
        Remote : A terraform registry, any external source like Git

we will see how to create the resources in both ways (local and remote)


## Local 


 Project Structure :

terraform-modules/local/
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars
│
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── ec2/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf


<img width="1022" height="843" alt="image" src="https://github.com/user-attachments/assets/c3d07413-f82a-4a58-a947-82e07004d520" />

## Defining the modules, resources, variables

### Module - VPC
/Modules/vpc/0-main.tf

<img width="1872" height="1071" alt="image" src="https://github.com/user-attachments/assets/06b1a75c-878b-465c-9670-148e8ecf08e8" />

/modules/vpc/1-variables.tf

<img width="1711" height="737" alt="image" src="https://github.com/user-attachments/assets/10e70d90-907f-4557-8b7a-d0a84663324d" />

/modules/vpc/2-outputs.tf

<img width="1705" height="713" alt="image" src="https://github.com/user-attachments/assets/66816f1f-c1df-48da-8e72-e2f9865464ce" />

### Module - EC2
/modules/ec2/0-main.tf

<img width="1687" height="633" alt="image" src="https://github.com/user-attachments/assets/b62d7176-fa39-44f4-9f3d-507a80af6acf" />

/modules/ec2/1-variables.tf

<img width="1519" height="565" alt="image" src="https://github.com/user-attachments/assets/b679ddb2-00da-472f-9e89-7f06579f7308" />

/modules/ec2/2-outputs.tf

<img width="1699" height="647" alt="image" src="https://github.com/user-attachments/assets/a57b87d3-7043-458e-b402-428b5cdf630a" />


### Root Module

0-main.tf

<img width="1699" height="682" alt="image" src="https://github.com/user-attachments/assets/54406696-4afd-4bcc-85b1-6579493f3a4a" />

1-variables.tf

<img width="1274" height="855" alt="image" src="https://github.com/user-attachments/assets/0da207d8-945b-4c3d-b3b8-6c41826371a7" />

2-terraform.tfvars

<img width="1888" height="607" alt="image" src="https://github.com/user-attachments/assets/534299e1-7bb9-43d6-b478-dfb5bf554cb1" />

3-output.tf

<img width="1683" height="516" alt="image" src="https://github.com/user-attachments/assets/07a1d0b6-37fc-4dc8-9f39-ecea13d34ef7" />


## It is very Important to understand the Flow

###  terraform init

  It downloads the AWS provider plugin and modules. It sets up .terraform directory and lock file
  Reads all our .tf file and do the resource mapping

### terraform apply

  Now , we have configured all out values under root(local here) - terraform.tfvar files 
  we have all the variables defined in root(local here) - variables
  And our root(local here) - main.tf calls the modules. 


  ***
Terraform.tfvars -> fills root module variables (not modules directly).

Root module -> passes values to child modules (VPC, EC2) explicitly via module.

Child Module’s variables.tf only describes what it expects — it doesn’t auto-pick values from tfvars. So, we have pass values explicitely thru root modules.

Once child module (VPC, EC2) gets the values from Root modules. It will start creating the resources 
 
 ***

## Execution

terraform init

We can see Backend initialized 
Modules and providers downloaded
Lock file .lock.hcl file created to record the provider selection


<img width="1813" height="582" alt="image" src="https://github.com/user-attachments/assets/9eec82f2-67f6-4055-98b6-7e57602e400e" />


terraform plan 

<img width="1768" height="323" alt="image" src="https://github.com/user-attachments/assets/a36697a0-43e4-416c-a579-cce078e0fbb1" />

It asks me the input one by one . But that is not the desired one .

Then when i pass the tfvar file explicitely it accepted 

<img width="1627" height="613" alt="image" src="https://github.com/user-attachments/assets/cca29ef1-b549-4528-a65a-168ca0636c13" />

The issue we have is the root file names -  0-main, 1-variable.tf , 2-terraform.tfvar

## Terraform need the root file names without prefix 

So, i am renaming them 

<img width="1617" height="535" alt="image" src="https://github.com/user-attachments/assets/9c4b9057-1ccf-416c-a745-bc61ee675d1a" />

Again Terraform init 
terraform plan 

This time it worked fine without passing -var-file 

<img width="1781" height="732" alt="image" src="https://github.com/user-attachments/assets/339625d3-4b64-4dc4-9a31-4e1a2e30ede0" />

<img width="1877" height="937" alt="image" src="https://github.com/user-attachments/assets/fc4f4d1f-d67d-4ec8-a0db-58da2918bbf5" />


terraform apply 

<img width="1757" height="921" alt="image" src="https://github.com/user-attachments/assets/0b9a0996-7785-4fab-bfb3-0b3296f43f1c" />



## Validation in console

### VPC and Resource Map

<img width="1916" height="946" alt="image" src="https://github.com/user-attachments/assets/7711b2be-85c2-475a-9cf5-eb4ca2b007c0" />


### Subnet

<img width="1904" height="893" alt="image" src="https://github.com/user-attachments/assets/fe24bfc5-749a-4e40-b9c0-8c52626f3614" />

### Route

Default Route with subnet association as we didnt configured separate route
<img width="1913" height="963" alt="image" src="https://github.com/user-attachments/assets/90dc60f9-45b0-4341-88d4-0fb5986b40e8" />

### Security Groups

<img width="1909" height="728" alt="image" src="https://github.com/user-attachments/assets/f2ff7180-42d6-42aa-8e0a-00ea5eb486f6" />

### EC2 instance 

<img width="1919" height="959" alt="image" src="https://github.com/user-attachments/assets/490cb95e-f79d-43ca-ae33-bc011d397a47" />

### Security Group Association

<img width="1900" height="956" alt="image" src="https://github.com/user-attachments/assets/3e61c332-42b7-4649-ac49-cbf71da05bfb" />

We can note that IGW , NAT GW are not created here , As we have configured the Child modules .

We will see how remote modules like terraform registry will help us in that case and how simiply our processes in next section



























     

