#!/usr/bin/python3
import json
import os

URL_BASE = "https://raw.githubusercontent.com/leludo84/vol3-linux-profiles/main/"
isf_datas = {
        "version": 1,
        "linux": {},
}

isf_output   = open("./banners-isf.json", "w")

with open("banners.ndjson") as  f:
    for l in f.readlines():
        d = json.loads(l)
        isf_datas["linux"][d["banner_b64"]] = [URL_BASE+d["symbols_file"]]

isf_output.write(json.dumps(isf_datas))
isf_output.close()

