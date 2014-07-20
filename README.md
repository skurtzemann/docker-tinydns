## tinydns in a container

Small Docker recipe to build `tinydns`. Tinydns is the DNS server from [djbdns](http://cr.yp.to/djbdns/tinydns.html)


### Zones file

Tinydns answers DNS queries as specified by `data.cdb`


#### `data.cdb`

* `data.cdb` file is a binary file created by [tinydns-data](http://cr.yp.to/djbdns/tinydns-data.html)
  * `tinydns-data` reads DNS informations from a file called `data` to create `data.cdb`


#### `data` in the container

* the container assumes the `data` file is symlink to `/data/tinydns.data`


### Usage

First, you need to create a correct [tinydns `data` file](http://cr.yp.to/djbdns/tinydns-data.html) on your host.

For example:

```
cat > /data/docker/volumes/tinydns-data/tinydns.data << EOF
.example.com:10.0.0.1:ns.example.com:3600
EOF
```

Then launch the container, with an external volume to the directory you created `tinydns.data` file

```
docker run -d -v /data/docker/volumes/tinydns-data/:/data -p 53:53/udp skurtzemann/tinydns
```

Then check that the DNS server is working

```
$ dig example.com soa @127.0.0.1 +short
ns.example.com. hostmaster.example.com. 1405869680 16384 2048 1048576 2560

$ dig ns.example.com @127.0.0.1 +short
10.0.0.1
```