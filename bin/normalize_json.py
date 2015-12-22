#!/usr/bin/env python
# normalize format:
# """{ "z": 9
#      "a": 0 }
# 200"""
# into sorted body, content-type (json/text) and status code:
# """{ "a": 0
#      "z": 9 }
# json"""
# 200"""
import sys
import json
lines = sys.stdin.readlines()
status_code = lines[-1].strip()
body = "".join(lines[:-1])
try:
  as_json = json.loads(body)
  print json.dumps(as_json, sort_keys=True, indent=2)
  print "content_type: json"
except ValueError, e:
  print body
  print "content_type: text"
print "status_code:", status_code
