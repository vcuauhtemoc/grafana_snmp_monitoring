#!/bin/bash

echo "enter encryption password:"
read -rs VAULT_PASS

echo "enter grafana username:"
read -rs GRAFANA_USER

echo "enter grafana password:"
read -rs GRAFANA_PASS

echo "enter SNMP read community:"
read -rs SNMP_RO

ENC_USER=$(ansible-vault encrypt_string --vault-password-file <(echo "$VAULT_PASS") $GRAFANA_USER --name grafana_user)
ENC_PASS=$(ansible-vault encrypt_string --vault-password-file <(echo "$VAULT_PASS") $GRAFANA_PASS --name grafana_pass)
ENC_SNMP_RO=$(ansible-vault encrypt_string --vault-password-file <(echo "$VAULT_PASS") $SNMP_RO --name snmp_read)

echo > group_vars/creds.yml

echo "$ENC_USER" >> group_vars/creds.yml
echo "$ENC_PASS" >> group_vars/creds.yml
echo "$ENC_SNMP_RO" >> group_vars/creds.yml


