#!/usr/bin/python3

import requests
import re
import os
import apt_pkg
apt_pkg.init_system()

def get_pkg(pkg_source, version):
    # get all package build from this linux source version 
    print("Looking for pkgs versions of ", pkg_source, version)
    response = requests.get("https://snapshot.debian.org/mr/package/"+pkg_source+"/"+version+"/allfiles?fileinfo=1")
    try:
        pkgs = response.json()["fileinfo"]
    except:
        print("*******************************************")
        print("ERROR")
        print(response)
        print("*******************************************")
        return

    for hash, a_pkg in pkgs.items():
        pkg = a_pkg[0]
        # Filtering
        if pkg["size"] < 10 * 1024 * 1024:
            continue
        if re.match("linux-image-.*-dbg.*_amd64\.deb$", pkg["name"]) is None:
            continue
        
        # Do
        print("Processing ", pkg)
        os.system("./profilator-debsnapshot.sh "+pkg["name"]+" https://snapshot.debian.org/archive/"+pkg["archive_name"]+"/"+pkg["first_seen"]+pkg["path"]+"/"+pkg["name"])

# Get all linux source versions

for source in [ "linux-2.6", "linux-2.6.16", "linux-2.6.24", "linux", "linux-4.9", "linux-4.19", "linux-5.10" ]:
    response = requests.get("https://snapshot.debian.org/mr/package/"+source+"/")
    response.json()
    source_versions=response.json()["result"]

    for d_source_version in source_versions:
        print("*Get ", source, d_source_version["version"])
        if re.match(".*exp1$", d_source_version["version"]) is not None:
            continue
        if re.match(".*exp2$", d_source_version["version"]) is not None:
            continue
        if re.match(".*experimental$", d_source_version["version"]) is not None:
            continue
        if re.match(".*experimental.*$", d_source_version["version"]) is not None:
            continue
        if os.environ["START_VERSION"] != "all":
            if apt_pkg.version_compare(d_source_version["version"], os.environ["START_VERSION"]) < 0 :
                continue
        if os.environ["END_VERSION"] != "all":
            if apt_pkg.version_compare(d_source_version["version"], os.environ["END_VERSION"]) > 0 :
                continue
        get_pkg(source, d_source_version["version"])

