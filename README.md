# docker-erfs-server

**NOTE**: You are in the wrong place. To use THC's 'Encrypted Remote File System' please go to [hackerschoice/erfs-client](https://github.com/hackerschoice/erfs-client)

This is the server side to run an 'Encrypted Remote File System'. This is only needed if you decide to run your own server instead of using rfs.thc.org.

The server software runs as an isolated docker instance. The example assumes 127.0.13.37 as the server's IP and port 2222 is used for testing.

---
**Installing the server software on the server**

```
$ docker build -t erfs-server github.com/hackerschoice/docker-erfs-server
```

Running the server:
```
$ mkdir -p ~/erfs
$ docker run -it -p 2222:22 --log-driver=none -v ~/rfs:/mnt/rfs erfs-server
```

---
**Testing the server**

See [hackerschoice/erfs-client](https://github.com/hackerschoice/erfs-client)

```
$ export THC_RFS_SERVER=127.0.13.37
$ export THC_RFS_PORT=2222
$ ./erfs init
```
