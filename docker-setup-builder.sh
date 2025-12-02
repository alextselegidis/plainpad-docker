#!/bin/bash

# -----------------------------------------------------------------------------
# Plainpad - Self Hosted Note Taking App
#
# @package     Plainpad
# @author      A.Tselegidis <alextselegidis@gmail.com>
# @copyright   Copyright (c) Alex Tselegidis
# @license     https://opensource.org/licenses/GPL-3.0 - GPLv3
# @link        https://plainpad.org
# -----------------------------------------------------------------------------

##
# Setup the builder locally for multi-arch images support.
#
# Before building with multi-arch support, a builder needs to be configured locally. This script
# will run the required commands for the builder to be ready to prepare the multi-arch images.
#
# Usage:
#
#  ./docker-setup-builder.sh
#

# Ensure QEMU is installed and configured:

docker run --privileged --rm tonistiigi/binfmt --install all

# Create a new builder instance to enable multi-architecture builds

docker buildx create --name multiarch-builder --use

# Verify the builder is active

docker buildx ls
