#!/bin/sh
# Tiny Core Linux specifics
. /etc/init.d/tc-functions

eAbort() {
    echo "${RED}${1}${NORMAL}"
    exit 1
}

usage() {
    echo "usage: `basename $0` [-i]"
    echo "if '-i' option provided -- attempt to install the extension shall be made"
    exit 2
}

while [ "${1}" ]; do
    case "${1}" in
        --help) usage;;
        -i) INSTALL=1;;
    esac
    shift
done

if [ ! -x bin/postfix ]; then eAbort "It looks like you didn't build. Please use 'make' first"; fi
echo "${BLUE}making extension...${NORMAL}"
strip bin/*
TMPDIR='/tmp/sqpostfix'
rm -rf "${TMPDIR}"
DST="${TMPDIR}"/usr/local/bin
mkdir -p "${DST}"
cp bin/* "${DST}"
TCZ='postfix.tcz'
rm -f /tmp/"${TCZ}"*
mksquashfs "${TMPDIR}"/ /tmp/"${TCZ}" > /dev/null
md5sum /tmp/"${TCZ}" > /tmp/"${TCZ}".md5.txt
echo 'db.tcz' > /tmp/"${TCZ}".dep
rm -rf "${TMPDIR}"
tcedir=`readlink /etc/sysconfig/tcedir`
if [ $INSTALL ]; then
    echo "${BLUE}installing...${NORMAL}"
    mv /tmp/"${TCZ}"* "${tcedir}"/optional/
	grep -v "${TCZ}" "${tcedir}/onboot.lst" > /tmp/onboot.lst
	echo "${TCZ}" >> /tmp/onboot.lst
	mv -f /tmp/onboot.lst "${tcedir}/"
    echo "${GREEN}done${NORMAL}"
    echo "${BLUE}run 'tce-load -i postfix' to load it${NORMAL}"
else
    echo "${BLUE}copy these to '${tcedir}'${NORMAL}"
    ls -l /tmp/"${TCZ}"*
    echo "${BLUE}and adjust 'onboot.lst'${NORMAL}"
fi
