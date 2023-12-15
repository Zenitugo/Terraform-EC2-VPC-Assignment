# STEP BY STEP SOLUTION OF PROJECT TASK

## DIRECTORY STRUCTURE
C:.
├───child-modules
│   ├───EC2-Instance
│   └───network
├───development
└───production


## CHILD MODULES
This directory contains sub-directories called **EC2_Instance** and **Network**.

### EC2-INSTANCE
This directory contains the main configuration file **(main.tf)**, the **variable.tf** file that accepts inputs that will be passed to the main.tf, and the **output.tf** file that is used to receive values we don't know at the time of writing the code

### Network 
This directory contains a main.tf file and variable.tf file is similar to EC2Instance but differs in that it has **data.tf** file which is used to query aws infrastructure so we can know the available availability_zones and attach each subnet to each availability zone.

## DEVELOPMENT & PRODUCTION
These are different environment that host the root modules. The root modules call the child modules before the infrastructure can be created. The two files in each of these environment are:
  - root-modules.tf
  - provider.tf
The provider.tf specifies the region and the provider where I want to create the infrastructure. In this case it was AWS, while the root modules specifies the values that will be passed as inputs in the variable.tf file in the child modules and later called upon by the main.tf in the EC2-Instance and network.


