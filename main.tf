# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.  
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html

resource "null_resource" "raspberry_pi_bootstrap" {
  connection {
    type = "ssh"
    user = "${var.username}"
    password = "${var.password}"
    host = "${var.raspberrypi_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      # SET HOSTNAME
      "sudo hostnamectl set-hostname ${var.new_hostname}",
      "echo '127.0.1.1 ${var.new_hostname}' | sudo tee -a /etc/hosts",
     
      # DATE TIME CONFIG
      "sudo timedatectl set-timezone ${var.timezone}",
      "sudo timedatectl set-ntp true",

      # CHANGE DEFAULT PASSWORD
      "echo 'pi:${var.new_password}' | sudo chpasswd",

      # SYSTEM AND PACKAGE UPDATES
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get dist-upgrade -y",
      "sudo apt --fix-broken install -y",

      # INSTALL PROMETHEUS NODE EXPORTER
      # This step optional, comment out this section if not desired
      "sudo apt-get install prometheus-node-exporter -y",
      "sudo systemctl enable prometheus-node-exporter.service",
      
      # NETWORKING - SET STATIC IP
      "echo 'interface eth0\nstatic ip_address=${var.static_ip_and_mask}\nstatic routers=${var.static_router}\nstatic domain_name_servers=${var.static_dns}' | cat >> /etc/dhcpcd.conf",
      
      # COPY KUBERNETES PREP SCRIPT
      "curl https://raw.githubusercontent.com/clayshek/terraform-raspberrypi-bootstrap/master/k8s_prep.sh > /home/pi/k8s_prep.sh",
      "chmod u+x k8s_prep.sh",
      
      # COPY HELM & TILLER SETUP
      "curl https://raw.githubusercontent.com/clayshek/terraform-raspberrypi-bootstrap/master/helm/tiller-rbac-config.yml > /home/pi/helm/tiller-rbac-config.yml",
      "curl https://raw.githubusercontent.com/clayshek/terraform-raspberrypi-bootstrap/master/helm/install-helm-tiller.sh > /home/pi/helm/install-helm-tiller.sh",
      "chmod u+x helm/install-helm-tiller.sh",

      # OPTIMIZE GPU MEMORY
      "echo 'gpu_mem=16' | sudo tee -a /boot/config.txt",

      # REBOOT
      # Changed from 'sudo reboot' to 'sudo shutdown -r +0' to address exit status issue encountered
      # after Terraform 0.11.3, see https://github.com/hashicorp/terraform/issues/17844
      "sudo shutdown -r +0"
    ]
  }
}
