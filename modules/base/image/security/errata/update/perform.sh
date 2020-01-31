#!/bin/bash
# Perform a minimal (only install the packages that have a security errata) security update of the underlying base image
set -eu

echo "Updating packages that have a security errata available"
yum update-minimal --security -y
