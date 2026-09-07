#!/bin/sh

# ensure required environment variables are set and define ppa directory
[ -z ${GPG_PRIVATE_KEY} ] && echo "Error: GPG_PRIVATE_KEY is unset" && exit 1
[ -z ${GPG_KEY_ID} ] && echo "Error: GPG_KEY_ID is unset" && exit 1
PPA_DIR=$GITHUB_WORKSPACE/ppa

# install required apt dependencies for building a repository index
sudo apt-get update
sudo apt-get install -y apt-utils dpkg-dev

# decode and import the gpg private key into the local keyring
echo -n $GPG_PRIVATE_KEY | base64 -d | gpg --import -q

# create and navigate into the binary package directory
mkdir -p "$PPA_DIR/deb"
cd "$PPA_DIR/deb"

# fetch latest packages from external repositories
while read -r repo; do
    [ -z "$repo" ] || [ "${repo#\#}" != "$repo" ] && continue
    gh release download --repo "$repo" --pattern "*.deb" --dir . --skip-existing
done < "$GITHUB_WORKSPACE/packages.txt"

# generate the packages index file from the downloaded binaries
dpkg-scanpackages -m . > Packages

# compress the packages index file
gzip -k -f Packages

# generate the release index file with checksums
apt-ftparchive release . > Release

# sign the release files and export the public key
gpg -abs -u $GPG_KEY_ID -o Release.gpg Release
gpg -u $GPG_KEY_ID --clearsign -o InRelease Release
gpg --export -a -u $GPG_KEY_ID -o "$PPA_DIR/ppa.gpg"

# dynamically generate the deb822 sources file with the embedded public key
cat <<SOURCES > "$PPA_DIR/ppa.sources"
Types: deb
URIs: https://ppa.parker.dev/deb
Suites: ./
Signed-By: |
$(sed 's/^/  /' "$PPA_DIR/ppa.gpg")
SOURCES
