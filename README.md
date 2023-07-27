# Volatility 3 Linux profiles
## Project

The goal of this project is to build and provide all possible Volatility 3 profiles for the main Linux distributions in x86_64 version.

This project contains all kernel versions including security updates.


## Profiles

| Distribution | Period | Count             |
| ------------ | ------ | ----------------- |
| Centos 6     | all    | 230               |
| Centos 7     | all    | 115 |
| Centos 8     | all    | 29 |
| Almalinux 8  | all    | 23                |
| Almalinux 9  | all    | 9                 |
| Ubuntu 16    | all    | 1123              |
| Ubuntu 18    | all    | 815               |
| Ubuntu 20    | ?      | 209               |
| Ubuntu 22    | April to now | 260               |
| Debian 7     | until 2018-06-01 | *Coming soon ...* |
| Debian 8     | until 2021-03-26 | *Coming soon ...* |
| Debian 9     | until 2022-06-22 | *Coming soon ...* |
| Debian 10    | all    | *Testing ...* |
| Debian 11    | all    | *Testing ...* |
| Debian 12    | all    | *Testing ...* |

:warning: Ubuntu 20 and 22 do not provide old packages in their repository (the last 15 or 20 kernels). We haven't profile older than this project. Use https://github.com/p0dalirius/volatility3-symbols for old symbols.

## Install profiles

Each of these profiles is packaged as a compressed `.json.xz` file. You can enable them individually in your Volatility installation by copying it in `volatility3/symbols/linux/`.

## Build

All processors are docker container. Build then with this script:

```bash
./make.sh
```

## Run

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



