SCRIPT_DIR=$(dirname "${0}")
${SCRIPT_DIR}/gke-creds.sh control fe-asaikali us-central1
${SCRIPT_DIR}/aws-creds.sh green-tap-view-1 us-east-2

