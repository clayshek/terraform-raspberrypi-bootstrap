# terraform-raspberrypi-bootstrap

## Summary

<a href="https://www.terraform.io/">Terraform</a> Provisioner for bootstrapping a <a href="https://www.raspberrypi.org">Raspberry Pi</a> base configuration. This is meant to be a run-once bootstrap Terraform <a href="https://www.terraform.io/docs/provisioners/index.html">provisioner</a> for a vanilla Raspberry Pi. Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.


## Requirements

- <a href="https://www.terraform.io/downloads.html">Terraform</a> (written with v0.11.3)
- A newly flashed Raspberry Pi (tested with Raspbian Stretch Lite, should work with prior version Jessie)
- SSH access to Pi, See <a href="https://www.raspberrypi.org/documentation/remote-access/ssh/">Enable SSH on a headless Raspberry Pi</a>

## Usage

- Clone the repository
- Customize the parameters in the terraform.tfvars file as applicable for provisioning.
- Run <code>terraform init</code> (required for first run). 
- Apply the configuration:

```
terraform apply
```


## To-Do

 - [ ] Add functionality for multiple Raspberry Pi deployments from a single run.
 - [ ] Implement tests.

 ## License

This is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).