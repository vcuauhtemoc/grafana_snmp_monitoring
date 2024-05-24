# Grafana SNMP Monitoring

A docker-compose which starts a Grafana service with a prometheus datasource, using snmp_exporter and blackbox_exporter to collect basic telemetry and diagnostics on any device running an SNMP agent.

## System Requirements

- This stack is designed to run in **any Linux environment.**
- Ensure [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html), [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) are installed natively in the Linux environment.
- Docker must be running **with root privileges.**

## Configuration

- Create the `custom_vars.yml` file in `ansible/playbooks/group_vars/` from the template:

  ``` BASH
  cp ansible/playbooks/group_vars/template.yml ansible/playbooks/group_vars/vars.yml
  ```

- Open `vars.yml` in a text editor, and add modules and host lists to monitor. the MIB directory is `snmp-exporter/generator/mibs`, with some default MIBs included. Put any additional MIBs in this folder.

  Example:

  ```YAML
  monitored_hosts: 
    - 192.168.196.208
    - 192.168.196.64

  snmp_modules:
    if_mib:
      walk:
        - interfaces
        - sysName
        - sysLocation
    ucd_snmp_mib:
      walk:
        - 1.3.6.1.4.1.2021
    host_resources_mib:
      walk:
        - hrSystem

  blackbox_modules:
    - icmp
    - http
  ```

  See [snmp_exporter](https://github.com/prometheus/snmp_exporter/tree/main?tab=readme-ov-file#prometheus-configuration) and [blackbox_exporter](https://github.com/prometheus/blackbox_exporter?tab=readme-ov-file#prometheus-configuration) for more configuration info.

- To configure a grafana username/password: in the `ansible/playbooks` directory, run `./encrypt_creds.sh`. Create a **vault password** for encrypting the credentials, then follow the prompts for entering the grafana username and password you want to configure.

- In the same directory, run: `ansible-playbook --ask-vault-pass main.yml`. You will be prompted for the **vault password** you just set in the previous step. Ensure the playbook ran through without failures.

### Run the Docker Containers

- In the root directory of the project, run `sudo docker-compose up -d`

- You can check the status of the prometheus services and targets at `http://localhost:9090/targets` and access Grafana at `http://localhost:3000`. You should be able to login with the credentials you provided previously. A sample dashboard collecting ping from monitored hosts is provided.
