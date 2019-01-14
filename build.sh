#!/bin/bash

# Desired version can be set by means of an enviromental variable
if [ -z "$KIBANA_VERSION" ]; then 
	# Default to Kibana 5.6.8
	KIBANA_VERSION=5.4.3; 
fi

KIBANA_DOWNLOAD_URI="https://artifacts.elastic.co/downloads/kibana"
KIBANA_DL_ARCHIVE="kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz"

OATH2_PROXY_DOWNLOAD_URI="https://github.com/bitly/oauth2_proxy/releases/download/v2.2/"
OATH2_PROXY_DL_ARCHIVE="oauth2_proxy-2.2.0.linux-amd64.go1.8.1.tar.gz"

IGNITER_DOWNLOAD_URI="https://master-7rqtwti-genoqvgjsstyw.us.platform.sh/utils/"
IGNITER_DL_ARCHIVE="igniter.tar.gz"

# Make directories
mkdir -p ${PLATFORM_APP_DIR}/kibana;

# Download and Extract Kibana
echo "Downloading ${KIBANA_DOWNLOAD_URI}/${KIBANA_DL_ARCHIVE}"
tar xzv -C ${PLATFORM_APP_DIR}/kibana --strip 1 < <(wget --no-cookies --no-check-certificate -q -O - ${KIBANA_DOWNLOAD_URI}/${KIBANA_DL_ARCHIVE})

# Download and extract Oath2 Proxy
tar xzv -C ${PLATFORM_APP_DIR}/bin --strip 1 < <(wget --no-cookies --no-check-certificate -q -O - ${OATH2_PROXY_DOWNLOAD_URI}/${OATH2_PROXY_DL_ARCHIVE})

# Download Igniter
tar xzv -C ${PLATFORM_APP_DIR}/bin --strip 1 < <(wget --no-cookies --no-check-certificate -q -O - ${IGNITER_DOWNLOAD_URI}/${IGNITER_DL_ARCHIVE})

# Remove default config and symlink it to actual
mv ${PLATFORM_APP_DIR}/kibana/config/kibana.yml ${PLATFORM_APP_DIR}/kibana/config/kibana.yml.origional
ln -s ${PLATFORM_APP_DIR}/config/kibana_config.yml ${PLATFORM_APP_DIR}/kibana/config/kibana.yml

# Make a symlink to the Igntite Configuration file
ln -s ${PLATFORM_APP_DIR}/config/igniterc ${PLATFORM_APP_DIR}/.igniterc

# Make a symlink to the Igntite state directory
ln -s ${PLATFORM_APP_DIR}/temp/.igniter ${PLATFORM_APP_DIR}/.igniter

