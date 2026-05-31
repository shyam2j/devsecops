SHELL := /bin/bash

.PHONY: help scan docs

help:
	@echo "Available targets:"
	@echo "  make scan    - run local DevSecOps scan commands"
	@echo "  make docs    - show documentation location"

scan:
	@./scripts/scan.sh

docs:
	@echo "Read docs/getting-started.md for usage and next steps"
