## PREREQUISITIES

Make sure you have development extensions and squashfs tools loaded, e.g.

```tce-load -i[w] compiletc squashfs-tools db-dev```


## BUILD

```make```


## MAKE EXTENSION

Still in the root of the source code, run

```./mktcz.sh```

This should build /tmp/postfix.tcz (and related checksum and dependencies files).
Follow TCL instructions to setup the extension.

The script have few options. To see them, type

```./mktcz --help```

Eventually, '`-i`' option shall install the extension.
Still, depending how you setup persistence, this might not
work for you. Touches of your '`bootlocal.sh`' (to start the
daemon on boot) might be necessary.

<sup> see [TCL persistence](http://wiki.tinycorelinux.net/wiki:start#persistence)</sup>

## REFERENCES
### Postfix
* [Official site](http://www.postfix.org/)
* [Wikipedia](https://en.wikipedia.org/wiki/Sendmail)
### Tiny Core Linux (TCL)
* [Official site](http://www.tinycorelinux.net/)
* [Custom extensions](http://wiki.tinycorelinux.net/wiki:extension_for_settings)
* [Creating extensions](http://wiki.tinycorelinux.net/wiki:creating_extensions)
