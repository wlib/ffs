# FFS - The Fast(er) File Sharer

## At a glance

FFS is a _fast_ file sharer, it utilizes zlib to compress files before serving,
and the client automatically knows to decompress and write out downloads.
The goal of this small console app is to make sharing files on your network
as simple as possible - a few keystrokes and done. Another target is to keep
the application easy to configure and very light-weight.
Features are also not overwhelming and easy to start on your first try.
You can even download from the server without installing a client - 
using telnet/netcat or your favorite web browser.
Written in Crystal, the program runs native binary code, 
while maintaining the amazing natural feel Ruby has to offer.

## Installing

Installation should never be hard, which is why binaries are available for
download in the /bin directory of each release. If you want to build from
source for your OS, there is a dependency:

+ [Crystal](https://crystal-lang.org/docs/installation/index.html)

Once you've installed Crystal, open a shell, clone, build, and install

`git clone https://github.com/wlib/ffs.git`
`cd ffs/src`

You can build to your desktop, or install it on your system if you are root

+ `crystal build ffs.cr -o ~/Desktop/ffs --release` puts on your desktop
+ `sudo crystal build ffs.cr -o /usr/bin/ffs --release` make executable for all

It's really that easy...

## Usage

FFS is simple enough for your grandma to figure out.

Start up a server like this:

`ffs -s -f myfile` > share myfile with your network

Retrieve with the client like this:

`ffs -c -i 10.1.2.34` > retrieve from a server with the ip address '10.1.2.34'

If you ever need help:

`ffs -h` or `ffs --help` is always there

## Contribute!

Contribute because it will make you feel good, and you're bored anyway
so why not?

1. [Fork the project](https://github.com/wlib/ffs/fork)
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am 'I added an awesome feature'`
4. Push to the branch `git push origin my-new-feature`
5. Create a new Pull Request on github

[Daniel Ethridge](https://github.com/wlib) - author
[You](https://yourwebsite.com) - helped add...
