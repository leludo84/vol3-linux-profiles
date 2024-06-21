#!/usr/bin/python3

import json
import os

URL_BASE = "https://raw.githubusercontent.com/leludo84/vol3-linux-profiles/main/"
isl_datas = {
        "version": 1,
        "linux": {},
}

isl_output   = open("./banners-isl.json", "w")

with open("banners.ndjson") as  f:
    for l in f.readlines():
        d = json.loads(l)
        isl_datas["linux"][d["banner_b64"]] = [URL_BASE+d["symbols_file"]]

isl_output.write(json.dumps(isl_datas))
isl_output.close()

