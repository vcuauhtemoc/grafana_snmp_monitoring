# Grafana SNMP Monitoring

A one-shot docker-compose which starts a Grafana service with a prometheus datasource, using snmp_exporter and blackbox_exporter to collect basic telemetry and diagnostics on any device running an SNMP agent.

## System Requirements

- Ensure [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html), [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) are installed on your local machine.
- Docker must be running with root privileges.

## Configuration

- Open the `custom_vars.yml` file in `ansible/playbooks/group_vars/` to add functionality and host lists to monitor.

Example:

```YAML
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

See [snmp_exporter](https://github.com/prometheus/snmp_exporter) and [blackbox_exporter](https://github.com/prometheus/blackbox_exporter) for more info.

- change directory to `ansible/playbooks` and run: `ansible-playbook main.yml` Ensure the playbook ran without failures.

### Run the Docker Containers

- In the root directory of the project, run `sudo docker-compose up -d`
- You can check the status of the prometheus services and targets at `http://localhost:9090/targets` and access Grafana at `http://localhost:3000`. A sample dashboard collecting ping from monitored hosts is provided.
