#!/bin/sh

# Load header
. ./header.inc

# Extract database configuration from enviroment
export KIBANA_ES_PORT=$(bin/json_env PLATFORM_RELATIONSHIPS billinges.billinges.port)
export KIBANA_ES_HOST=$(bin/json_env PLATFORM_RELATIONSHIPS billinges.billinges.host)
export KIBANA_ES_SCHEME=$(bin/json_env PLATFORM_RELATIONSHIPS billinges.billinges.scheme)
export KIBANA_ES_URL="${KIBANA_ES_SCHEME}://${KIBANA_ES_HOST}:${KIBANA_ES_PORT}"

echo "Generating Configuration..."

# Generate a databse configuration
cat << EOF > ${PLATFORM_APP_DIR}/config/kibana_config.yml
elasticsearch.url: ${KIBANA_ES_URL}
path.data: ${KIBANA_HOME}/data
pid.file: ${PLATFORM_APP_DIR}/temp/kibana.pid
logging.verbose: true
EOF

# Generate Configuration for Ignite Process Manager
cat << EOF > ${PLATFORM_APP_DIR}/config/igniterc
[[process]]
name = "kibana"
cmd = "${KIBANA_HOME}/bin/kibana"
args = [["--verbose"]]

[[process]]
name = "oauth2proxy"
cmd = "${PLATFORM_APP_DIR}/bin/oauth2_proxy"
args = [["-config", "${PLATFORM_APP_DIR}/config/oauth2_proxy.cfg"], ["-cookie-secret", "${PLATFORM_PROJECT_ENTROPY}"], ["-http-address", "http://localhost:${PORT}"], ["-upstream", "http://localhost:5601/"]]
EOF

# Create the temp directory to hold igniter state
mkdir -p ${PLATFORM_APP_DIR}/temp/.igniter

