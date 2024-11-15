#!/usr/bin/env ruby

require 'base64'
require 'json'
require 'net/http'
require 'net/https'
require 'dotenv'

# test in production:
#$mesa_logs_url = 'https://logs.mesastar.org/uploads'
#$use_ssl = true
$mesa_logs_url = 'https://mesa-logs.flatironinstitute.org/uploads'
$use_ssl = true
# test locally:
$mesa_logs_url = 'https://localhost:8000/uploads'
$use_ssl = false
# test docker:
$mesa_logs_url = 'https://localhost:80/uploads'
$use_ssl = false

def b64_file(filename)
  Base64.encode64(File.open(filename).read)
end


def send_json_test_case
  uri = URI($mesa_logs_url)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = $use_ssl
  req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json',
                            'X-Api-Key' => ENV['MESALOGS_TEST_API_KEY'])
  req.body = {"computer_name": "ruby_example",
              "commit": "427c21b",
              "test_case": "custom_colors",
              "mk.txt": b64_file('mk.txt'),
              "out.txt": b64_file('out.txt'),
              "err.txt": b64_file('err.txt'),
             }.to_json
  res = https.request(req)
  puts "response #{res.body}"
rescue => e
  puts "failed #{e}"
end

send_json_test_case


def send_json_build
  uri = URI($mesa_logs_url)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = $use_ssl
  req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json',
                            'X-Api-Key' => ENV['MESALOGS_TEST_API_KEY'])
  req.body = {"computer_name": "ruby_example",
              "commit": "427c21b",
              "build.log": b64_file('build.log'),
             }.to_json
  res = https.request(req)
  puts "response #{res.body}"
rescue => e
  puts "failed #{e}"
end

send_json_build
