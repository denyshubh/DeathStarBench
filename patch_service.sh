#!/bin/bash

# Set the namespace
NAMESPACE="default"
PORT_PREFIX="tcp-"
EXCLUDED_SERVICE="kubernetes"

# Get all service names in the specified namespace
services=$(kubectl get svc -n $NAMESPACE -o jsonpath='{.items[*].metadata.name}')

# Iterate over the services and update the port names
for svc in $services; do
  if [ "$svc" != "$EXCLUDED_SERVICE" ]; then
    echo "Patching service: $svc"
    # Get the number of ports for the current service
    port_count=$(kubectl get svc $svc -n $NAMESPACE -o jsonpath='{.spec.ports[*].name}' | wc -w)

    # Iterate over the ports and update their names
    for ((i = 0; i < port_count; i++)); do
      port_name=$(kubectl get svc $svc -n $NAMESPACE -o jsonpath="{.spec.ports[$i].name}")
      port_protocol=$(kubectl get svc $svc -n $NAMESPACE -o jsonpath="{.spec.ports[$i].protocol}")

      if [[ ! $port_name =~ ^$PORT_PREFIX ]] && [ "$port_protocol" != "UDP" ]; then
        new_port_name="${PORT_PREFIX}$((i + 1))"
        echo "Updating port $port_name to $new_port_name"

        # Patch the service to update the port name
        kubectl patch svc $svc -n $NAMESPACE -p "{\"spec\": {\"ports\": [{\"name\": \"$new_port_name\", \"port\": $(kubectl get svc $svc -n $NAMESPACE -o jsonpath="{.spec.ports[$i].port}") }]}}"
      fi
    done
  fi
done
