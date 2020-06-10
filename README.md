# docker-thc-rfs-server

**NOTE**: You are in the wrong place. To use THC's 'Encrypted Remote File System' please go to [hackerschoice/thc-rfs-client](https://github.com/hackerschoice/thc-rfs-client)

This is the server side to run an 'Encrypted Remote File System'. This is only needed if you decide to run your own server instead of using rfs.thc.org.

The server software runs as an isolated docker instance. The example assumes 127.0.13.37 as the server's IP and port 2222 is used for testing.

---
**Installing the server software on the server**

```
$ docker build -t thc-rfs-server github.com/SkyperTHC/thc-rfs-server
```

Running the server:
```
$ mkdir -p ~/thc-rfs
$ docker run -it -p 2222:22 --log-drive=none -v ~/thc-rfs:/mnt/rfc thc-rfs-server
```

---
**Testing the server**

Retrieve a new RFS-SECRET:
```
$ ssh -p 2222 rfs-init@127.0.13.37
```

Write down the RFS-SECRET. Keep this RFS-SECRET *secret* unless you intentionally wish to share access to the remote files. Mount the Remote File Share via SSH:
```
$ mkdir -p ~/thc/rfs
$ sshfs -p 2222 -o allow_other,default_permissions,IdentityFile=~/thc/etc/id_rsa-rfs <SECRET>@127.0.13.37:rw ~/thc/rfs
```

Test write some data to the Remote File System directory.
```
$ echo "Hello World" >~/thc/rfs/cleartext-file.txt
```

Create an encrypted volume. Encryption happens locally. The encrypted data is then send via ssh to the server (double encrypted):
```
$ mkdir -p ~/thc/sec
$ SEC=`dd if=/dev/urandom bs=1 count=32 2>/dev/null | openssl base64 | sed 's/[^a-zA-Z0-9]//g' | head -n1 | cut -c1-16`
$ echo "Use this password when asked: sec${SEC}"
$ encfs --standard ~/thc/rfs/encrypted ~/thc/sec
```

The server has no knowledge of your password. Only you can access your data. Keep the RFS-Secret and the PASSWORD secure. Do not loose them. There is no way to your data without the PASSWORD.

Unmount everything:
```
$ encfs -u ~/thc/sec
$ umount -f ~/thc/rfs
```


