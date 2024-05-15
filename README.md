# Grafana Monitoring Project

A one-shot docker-compose which starts a Grafana service with a prometheus datasource, using snmp_exporter and blackbox_exporter to collect basic telemetry and diagnostics on any device running an SNMP agent.

## Configuration

Ensure Ansible is installed on your local machine.

- Open the `custom_vars.yml` file in `ansible/playbooks/group_vars/` to add functionality and host lists to monitor.
Example:
```
grafana_user: admin
grafana_password: password
monitored_hosts:
  - 192.168.196.208
  - 192.168.196.64

snmp_modules:
  - if_mib
  - ucd_snmp_mib

blackbox_modules:
  - icmp
  
```
