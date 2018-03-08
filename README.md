# Generate Vagrantfile topology based upon Netbox IPAM data in a Saltstack environment.

## Usage
* Clone repo to salt folder
* Set up pillar with vagrant user and output_folder
* Set up Netbox topology with:
    * devices
    * device types
    * device connections
    * circuits
    * circuit terminations
    * Prefixes (inc carrier role if desired)
    * IP addresses (inc carrier description if desired)
* vagrant-net device role (or change the templates)
* `sudo salt 'minion' state.apply vagrant_net`
* `cd /<output folder>/<netbox-tenant-name>`
* `vagrant up`

## Requirements:
* Salt bundled with the netbox modules configured with appropriate pillar information (url, token, private_key_file)
* Align vagrant_net_data.jinja box keys with appropriate vagrant boxes and Netbox names (example provided below)
* PE IP addresses for circuit terminations must have roles and description assigned
* Maximum of 7 devices connected to PE at this stage
* Juniper vagrant plugin should be installed for any auto config
* BYO Cisco vagrant boxes as they are not hosted by Hashi

## Notes:
Circuits/terminations only needed if simulating MPLS/internet provider outside IPAM (so PE isn't managed in IPAM)
IP Addresses only needed for Juniper auto config

### Example Pillar:
```
vagrant:
    username: vagrant
    output_folder: /srv/salt/output
```
### Example box dictionary:
Keys must match Netbox device type slug
```
{% set box = {
    'vsrx': 'juniper/ffp-12.1X47-D15.4-packetmode',
    'csr1000v': 'iosxe/16.07.01',
    'nexus9kv': 'cisco/nxos7.0.3'
    }
%}
```
