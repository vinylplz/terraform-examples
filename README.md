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
