#!/bin/sh

# Load header
. ./header.inc

# Start Igniter (starts Kibana and OauthProxy)
${PLATFORM_APP_DIR}/bin/igniter

# Since igniter exits after launch, this is required.
tail -f
