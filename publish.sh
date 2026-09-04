#!/bin/sh

[ -z ${GPG_PRIVATE_KEY} ] && echo "Error: GPG_PRIVATE_KEY is unset" && exit 1
[ -z ${GPG_KEY_ID} ] && echo "Error: GPG_KEY_ID is unset" && exit 1
PPA_DIR=$GITHUB_WORKSPACE/ppa

sudo apt-get update
sudo apt-get install -y apt-utils dpkg-dev

echo -n $GPG_PRIVATE_KEY | base64 -d | gpg --import -q

cd "$PPA_DIR/deb"

dpkg-scanpackages -m . > Packages

gzip -k -f Packages

apt-ftparchive release . > Release

gpg -abs -u $GPG_KEY_ID -o Release.gpg Release
gpg -u $GPG_KEY_ID --clearsign -o InRelease Release
gpg --export -a -u $GPG_KEY_ID -o "$PPA_DIR/ppa.gpg"

cat <<SOURCES > "$PPA_DIR/ppa.sources"
Types: deb
URIs: https://ppa.parker.dev/deb
Suites: ./
Signed-By: |
$(sed 's/^/  /' "$PPA_DIR/ppa.gpg")
SOURCES
