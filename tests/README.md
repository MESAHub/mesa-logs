The Flask app creates an endpoint at: https://logs.mesastar.org/uploads

This accepts only POST requests with JSON payloads (Content-Type: application/json).

You must provide a valid API key in the X-Api-Key header of the request.

The json should have the following things:

  computer_name - string with computer name
  commit - string with SHA of commit
  test_case - string with name of test case

It can have:

  mk.txt  - base64 encoded contents of mk.txt
  out.txt - base64 encoded contents of out.txt
  err.txt - base64 encoded contents of err.txt


This then creates a directory available at

  https://logs.mesastar.org/<commit>/<computer_name>/<test_case>/

and makes any of the txt files provided available.

An example of the basic API is provided by:

  send_json.sh - example using CURL (no files)
  send_json.rb - ruby example (all 3 files)

(these two examples require you to define an environment variable `MESALOGS_TEST_API_KEY` -- remember: never make this secret key public / commit it to a repository)
