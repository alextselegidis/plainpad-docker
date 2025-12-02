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
# Build a docker image for a Plainpad release with local architecture
#
# This script will create a new local Docker image with the local architecture only. This is useful for testing
# or using the image locally. For multiple architectures refer to the "multi-arch-build.sh" script.
#
# Usage:
#
#  ./docker-build.sh <version>
#
# Example:
#
#   ./docker-build.sh 1.5.0
#

DEFAULT_VERSION=1.5.0

VERSION="${1:-$DEFAULT_VERSION}"

docker build --tag alextselegidis/plainpad:${VERSION} --build-arg VERSION=${VERSION} .
