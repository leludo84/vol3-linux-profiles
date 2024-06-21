#!/usr/bin/python

import sys
import json
import base64
import os

if len(sys.argv) != 2:
    print("json symbols file path needed.")
    sys.exit(-1)

filename = sys.argv[1]

f = open(filename, "r")
data = json.load(f)

banner = base64.b64decode(data["symbols"]["linux_banner"]["constant_data"])
if not isinstance(banner, str):
    banner = banner.decode('ASCII')

banner = banner.split('\n')[0]

output = {
    "symbols_file": os.path.basename(filename+".xz"),
    "banner": banner,
    "banner_b64": data["symbols"]["linux_banner"]["constant_data"],
}

print(json.dumps(output))

