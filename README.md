# docker-thc-rfs-server

**NOTE**: You are in the wrong place. To use THC's 'Encrypted Remote File System' please go to [hackerschoice/thc-rfs-client](https://github.com/hackerschoice/thc-rfs-client)

This is the server side to run an 'Encrypted Remote File System'. This is only needed if you decide to run your own server instead of using rfs.thc.org.

The server software runs as an isolated docker instance. The example assumes 127.0.13.37 as the server's IP and port 2222 is used for testing.

---
**Installing the server software on the server**

```
$ docker build -t thc-rfs-server github.com/hackerschoice/docker-thc-rfs-server
```

Running the server:
```
$ mkdir -p ~/thc-rfs
$ docker run -it -p 2222:22 --log-drive=none -v ~/thc-rfs:/mnt/rfs thc-rfs-server
```

---
**Testing the server**

See [hackerschoice/thc-rfs-client](https://github.com/hackerschoice/thc-rfs-client)

```
$ export THC_RFS_SERVER=127.0.0.1
$ export THC_RFS_PORT=2222
$ ./thc-rfs init
```
