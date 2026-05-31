#!/usr/bin/env bash
set -euo pipefail

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "DevSecOps local scan started"

echo "1) Checking required tools"
for tool in checkov trivy; do
  if ! command_exists "$tool"; then
    echo "- $tool not installed"
  else
    echo "- $tool available"
  fi
done

if command_exists checkov; then
  if find . -maxdepth 2 \( -name '*.tf' -o -name '*.yml' -o -name '*.yaml' -o -name 'Dockerfile' \) | grep -q .; then
    echo "Running Checkov IaC scan"
    checkov -d .
  else
    echo "Skipping Checkov: no supported IaC files found"
  fi
else
  echo "Install Checkov to enable IaC scanning: pip install checkov"
fi

if command_exists trivy; then
  echo "Running Trivy filesystem scan"
  trivy fs --severity HIGH,CRITICAL .
else
  echo "Install Trivy to enable filesystem scanning: https://aquasecurity.github.io/trivy/"
fi

echo "DevSecOps local scan complete"
