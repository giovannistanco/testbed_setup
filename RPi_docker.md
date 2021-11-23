Uninstall old versions
```
 sudo apt-get remove docker docker-engine docker.io containerd runc
```
We install Docker using the convenience script available at [get.docker.com](get.docker.com). We use nthe `DRY_RUN=1` option to learn what steps the script will execute during installation. 
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
We get this error
```
# Executing docker install script, commit: 93d2499759296ac1f9c510605fef85052a2c32be
+ sh -c apt-get update -qq >/dev/null
E: Repository 'http://raspbian.raspberrypi.org/raspbian buster InRelease' changed its 'Suite' value from 'stable' to 'oldstable'
E: Repository 'http://archive.raspberrypi.org/debian buster InRelease' changed its 'Suite' value from 'testing' to 'oldstable'
```

