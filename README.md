# Volatility 3 Linux profiles

## Project

The goal of this project is to build and provide all possible Volatility3 profiles for the main Linux distributions in **x86_64** version only.

This project contains all kernel versions including security updates.


## Profiles

| Distribution | Period                 | Path                                    | Count             |
| ------------ | ---------------------- | --------------------------------------- | ----------------- |
| Almalinux 8  | all                    | [profiles/almalinux8/](profiles/almalinux8/)                | 35              |
| Almalinux 9  | all                    | [profiles/almalinux9/](profiles/almalinux9/)                | 19               |
| Centos 6     | all                    | [profiles/centos6/](profiles/centos6/)                    | 230               |
| Centos 7     | all                    | [profiles/centos7/](profiles/centos7/)                   | 116              |
| Centos 8     | all                    | [profiles/centos8/](profiles/centos8/)                   | 29                |
| Ubuntu 16    | all                    | [profiles/ubuntu16/](profiles/ubuntu16/)                  | 778               |
| Ubuntu 18    | all                    | [profiles/ubuntu18/](profiles/ubuntu18/)                  | 812               |
| Ubuntu 20    | from 2021-10-12 to now | [profiles/ubuntu20/](profiles/ubuntu20/)                  | 566               |
| Ubuntu 22    | from April 2023 to now | [profiles/ubuntu22/](profiles/ubuntu22/)                  | 580               |
| Ubuntu 24    | from June 2024 to now  | [profiles/ubuntu24/](profiles/ubuntu24/)                  | 30                |
| Debian 6 to 12 (debian snapshot) | all                    | [profiles/debian-snapshot/](profiles/debian-snapshot/) | 1995 |
| Debian 10 (last)    | from 2022-03-07 to now | [profiles/debian10/](profiles/debian10/)                  | 63             |
| Debian 11 (last)    | from 2022-03-07 to now | [profiles/debian11/](profiles/debian11/)                 | 51             |
| Debian 12 (last) | from 2023-05-08 to now | [profiles/debian12/](profiles/debian12/)                     | 36             |

:warning: Ubuntu 20, 22 and 24 do not provide old packages in their repository (the last 15 or 20 kernels). We haven't profile older than this project. Use https://github.com/p0dalirius/volatility3-symbols for old symbols.

## Where is my profile ?

The are two methods to find your profile:

1.  Use the kernel package name with version and add *-dbg*, *-dbgsym* or *-debuginfo*, depending on the linux distribution;
2.  Use Linux banners index (*banners.ndjson*), for example:

```bash
grep "Linux version 6.2.0-1007-aws (buildd@lcy02-amd64-106) (x86_64-linux-gnu-gcc-11 (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #7~22.04.1-Ubuntu SMP Fri Jul  7 13:49:28 UTC 2023 (Ubuntu 6.2.0-1007.7~22.04.1-aws 6.2.13)" banners.ndjson | jq .symbols_file

"linux-image-unsigned-6.2.0-1007-aws-dbgsym_6.2.0-1007.7~22.04.1_x86_64.json.xz"

```

> Note: the banner is recovered via the volatility3 plugin **banners.Banners**.

## Symbols file automatic download in Volatility3

Volatility can automatically download the symbols file by entering the address of an ISF server. It will download the *banners-isf.json* index directly from github where it will find the symbols file URL.

Set the constant **REMOTE_ISF_URL** to *https://raw.githubusercontent.com/leludo84/vol3-linux-profiles/main/banners-isf.json* in **volatility3/framework/constants/\_\_init\_\_.py**.

## Install profiles manualy

Each of these profiles is packaged as a compressed `.json.xz` file. You can enable them individually in your Volatility installation by copying it in `volatility3/symbols/linux/`.

## The profilator

### Build the profilator

All processors are docker container. Build then with this script:

```bash
cd sources
make
```

### Run

## How manually build a Linux profile

> Creating a profile for Volatility 3 does not require installing a Linux identical to the sampled machine.

### dwarf2json installation

On the analysis machine, download and compile **dwarf2json** from https://github.com/volatilityfoundation/dwarf2json

```bash
# if Go not installed:
apt install golang-go -y

# Downloadind and compiling
git clone https://github.com/volatilityfoundation/dwarf2json.git
cd dwarf2json/
go build
```

> Compiling need Go  1.14 or higher.

### Linux kernel with debug symbol

To create a profile with **dwarf** , you must download or install a linux kernel with the debugging symbols of a version strictly equal to that of the sampling.

According to the distributions, the name of the corresponding package is the following:

|  Distro   | Package name                         |        Repository        |        Archive repository         |
| :-------: | ------------------------------------ | :----------------------: | :-------------------------------: |
|  Debian   | **linux-image-$(uname -r)-dbg**      |          *main*          |    http://snapshot.debian.org/    |
|  Ubuntu   | **linux-image-$(uname -r)-dbgsym**   | http://ddebs.ubuntu.com/ |             **none**              |
|  CentOS   | **kernel-debuginfo-$(uname -r).rpm** |      base-debuginfo      |     https://vault.centos.org/     |
|  RedHat   | **kernel-debuginfo-$(uname -r).rpm** |        RHEL, RHN         |        RedHat Netwok (fee)        |
| AlmaLinux | **kernel-debuginfo-$(uname -r).rpm** |     baseos-debuginfo     | https://repo.almalinux.org/vault/ |

> The package can be either installed or unpacked on any OS with 7zip for example.

More informations:

- https://access.redhat.com/solutions/9907
- https://www.ibm.com/docs/en/linux-on-systems?topic=linuxonibm/liacf/oprofkernelsymrhel.html
- https://wiki.ubuntu.com/Debug%20Symbol%20Packages

> Debian: if the package is no longer present on the repository, it is possible to go back in time with http://snapshot.debian.org/ . Find and download the package from the home page search engine.

### Build profile

```bash
./dwarf2json linux --elf /usr/lib/debug/boot/vmlinux-4.4.0-137-generic > linux-4.4.0.json
cp linux-4.4.0.json <volatility3>/symbols/

```

> In some cases, adding the option *--system-map System-map-$(uname -r)* may be necessary when creating the profile.

### Test

```bash
python3 vol.py -vvvv -f ram.img linux.pslist.PsList
```
