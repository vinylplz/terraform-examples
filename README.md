# terraform-examples
Example `terraform` configurations

---
`terraform` is a command line utility from [HashiCorp](http://hashicorp.com), the makers of Vagrant.

From the [official website](https://terraform.io/intro/index.html):

> Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.
>
> Configuration files describe to Terraform the components needed to run a single application or your entire datacenter. Terraform generates an execution plan describing what it will do to reach the desired state, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and create incremental execution plans which can be applied.
>
> The infrastructure Terraform can manage includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc.

---

This repo contains example configuration for setting up various AWS environments.

* [simple] - Super basic config consisting of a single EC2 instance and Elasitic IP.  Large portions have been lifted from the offial terraform [getting started guide] and [documentation].  If you are just getting started with `terraform`, this is a great place to start.
* [vpc] - More advanced, real-world example of a mutli-availability-zone, multi-tier VPC with public and private subnets, and a "NAT" of the style produced by the AWS VPC Wizard.  It is designed to be *extensible*, *secure*, *fault-tolerant*, and *scalable*.  If you are considering using `terraform` to manage a small to medium sized production-level AWS environment, and have successfully launched the [simple] example, this is an excellent place to start.


## Quick Start

1. Install terraform using the instructions in the [getting started guide]  
2. Setup AWS access keys [using IAM](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html)
 * Required permissions will vary depending on what you're managing with terraform
 * Hang onto you access_key and secret_access_key.  We'll need them in a second
3. Create an ssh_key in the [EC2 management console](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) (if you want to be able to log into your machines)
4. Clone this repo  

    ```sh
    $ git clone http://github.com/vinylplz/terraform-examples.git  
    ```
5. Create and edit terraform.tfvars in the directory for the environment you want to launch (e.g. simple/).  This file does *not* get stored in version control.  Update the values for 'access_key', 'secret_key', and 'ssh_key' (if applicable) with the values you made above.  

    ```sh
    $ cd terraform-examples/simple  
    $ cp terraform.tfvars.example terraform.tfvars  
    $ vim terraform.tfvars  
    ```
6. (Optional) Run `terraform plan` and `terraform graph` to see what resources terraform will attempt to create and their dependancies.  

    ```sh
    $ terraform plan  
    {snip}  
    $ terraform graph | dot -Tjpg > graph.jpg  
    ```
7. Run `terraform apply` to launch your environment.  `terraform` is still in active development; you may need to run this twice to verify everything synced properly. 

    ```sh
    $ terraform apply  
   {snip}  
   $ terraform apply  
   {snip}
   ```
8. (Optional) Pop open your [AWS console](https://console.aws.amazon.com/) to verify resources were created
9. When you're all done, destroy the resources you created so you don't get charged.  You should also do this twice to be sure.  

    ```sh
    $ terraform destroy  
    {snip}  
    $ terraform destroy  
    {snip}  
    ```


See also:  
Official [homepage]  
Official [documentation]  
Official [getting started guide]  
Official [github] page    

[homepage]: https://terraform.io  
[documentation]: https://terraform.io/docs/index.html  
[getting started guide]: https://terraform.io/intro/getting-started/install.html  
[github]: https://github.com/hashicorp/terraform  

[simple]: ./simple  
[vpc]: ./vpc  
