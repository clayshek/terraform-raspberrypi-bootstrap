# terraform-raspberrypi-bootstrap

## Summary

<a href="https://www.terraform.io/">Terraform</a> Provisioner for bootstrapping a <a href="https://www.raspberrypi.org">Raspberry Pi</a> base configuration. This is meant to be a run-once bootstrap Terraform <a href="https://www.terraform.io/docs/provisioners/index.html">provisioner</a> for a vanilla Raspberry Pi. Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.

This also installs the Prometheus Node Exporter for Prometheus metrics collection; and also copies the k8s_prep.sh script from this repository to /home/pi/ to optionally install & configure prerequisites for latest ARM release of Kubernetes, including Docker, based off of https://gist.github.com/alexellis/fdbc90de7691a1b9edb545c17da2d975. 


## Requirements

- <a href="https://www.terraform.io/downloads.html">Terraform</a> (written with v0.11.3, tested working up to 0.11.8)
- A newly flashed Raspberry Pi (tested with Raspbian Stretch Lite through 2018-06-27 release, should work with prior version Jessie)
- SSH access to Pi, See <a href="https://www.raspberrypi.org/documentation/remote-access/ssh/">Enable SSH on a headless Raspberry Pi</a>

## Usage

- Clone the repository
- Customize the parameters in the terraform.tfvars file as applicable for provisioning.
- Run <code>terraform init</code> (required for first run). 
- Apply the configuration:

```
terraform apply
```

- Optional, run <code>./k8s_prep.sh</code> to install Kubernetes and prerequisites, including Docker. 

## To-Do

 - [X] Add Prometheus Node Exporter install.
 - [ ] Possibly add functionality for multiple Raspberry Pi deployments from a single run, using <a href="https://www.terraform.io/docs/configuration/resources.html#using-variables-with-count">variables with count</a>.
 - [ ] Implement tests.

 ## License

This is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
