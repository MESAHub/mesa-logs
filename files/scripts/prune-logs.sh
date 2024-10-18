#!/bin/sh

find /var/www/mesa-logs/uploads/ -maxdepth 1 -type d -mtime +60 -exec rm -rf {} +
