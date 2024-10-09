#!/usr/bin/env python

import secrets
length = 32
generated_key = secrets.token_urlsafe(length)
print(generated_key)
