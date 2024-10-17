#!/usr/bin/env bash

gunicorn --bind 0.0.0.0:8000 --workers=4 uploads:app