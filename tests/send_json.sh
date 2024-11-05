#!/bin/bash
if [[ -n $1 ]]; then
  echo "Submitting test case on port $1."
  MESA_PORT=$1
else
  echo "No port provided. Attempting to submit test case on port 80."
  MESA_PORT=80
fi

if [[ -z "${MESALOGS_TEST_API_KEY}" ]]; then
  echo "[Error] MESALOGS_TEST_API_KEY is not set."
  exit 1
fi

echo "Sending test case:"
echo "    API Key: ${MESALOGS_TEST_API_KEY}"

curl --header "X-Api-Key: $MESALOGS_TEST_API_KEY" \
     --header "Content-Type: application/json" \
     --request POST \
     --data '{"computer_name":"curl_example", "commit":"427c21b", "test_case":"1.3M_ms_high_Z"}' \
http://localhost:${MESA_PORT}/uploads
#http://mesa-logs.flatironinstitute.org/uploads
#https://logs.mesastar.org/uploads

