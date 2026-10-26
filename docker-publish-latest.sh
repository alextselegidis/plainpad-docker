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
# Publish a docker image tag for a Plainpad release.
#
# Usage:
#
#  ./docker-publish-latest.sh <version>
#
# Example:
#
#   ./docker-publish-latest.sh 1.5.0
#

DEFAULT_VERSION=1.2.0

VERSION="${1:-$DEFAULT_VERSION}"

docker buildx build --push --platform linux/amd64,linux/arm64 -t alextselegidis/plainpad:latest --build-arg VERSION=${VERSION} .
