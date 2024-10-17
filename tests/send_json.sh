#!/bin/bash

curl --header "X-Api-Key: $MESALOGS_TEST_API_KEY" \
     --header "Content-Type: application/json" \
     --request POST \
     --data '{"computer_name":"curl_example", "commit":"427c21b", "test_case":"1.3M_ms_high_Z"}' \
http://localhost/uploads
#http://localhost:8000/uploads
#https://logs.mesastar.org/uploads
