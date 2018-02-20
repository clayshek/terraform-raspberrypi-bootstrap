# Terraform Variables
# Customize parameters in this file specific to your deployment.
# Current & new passwords can be supplied here, but safer to supply variables inline when applying config:
# terraform apply -var 'password=PASSWORD' -var 'new_password=NEWPASS'

# CONNECTION PARAMETERS
raspberrypi_ip = "192.168.1.131"
username = "pi"
password = "raspberry"

# CONIGURATION PARAMETERS
new_hostname = ""
new_password = ""
# Validate timezone correctness against 'timedatectl list-timezones' 
timezone = "America/New_York"

# NETWORK CONFIGURATION PARAMETERS
# See man dhcpcd.conf for further info and examples. 
# Get these right or risk loss of network connectivity.
static_ip_and_mask = "192.168.1.20/24"
static_router = "192.168.1.1"
static_dns = "192.168.1.1"