#! /bin/bash

RFS_BIN_DIR=`dirname "${0}"`
ROOT_DIR=/mnt/rfs

# Let's store passwd and user data on host...
if [ ! -f "${ROOT_DIR}"/passwd ]; then
	echo "No Database found."
	echo "No existing file shares found"
	echo "This appears to be a NEW system."
	echo "Setting up new system."
	cp -f /etc/passwd "${ROOT_DIR}/"
	cp -f /etc/shadow "${ROOT_DIR}/"
	mkdir -p "${ROOT_DIR}/ssh"
	cp -f /etc/ssh/ssh_host_* "${ROOT_DIR}/ssh"
else
	echo "Using existing database..."
	cp -f ${ROOT_DIR}/passwd /etc/
	cp -f ${ROOT_DIR}/shadow /etc/
	cp -f "${ROOT_DIR}/ssh/"ssh_host_* /etc/ssh/
fi

/etc/init.d/ssh start
[ ! -d "${ROOT_DIR}/data" ] && mkdir "${ROOT_DIR}/data"
echo "Running rfsd...."
"${RFS_BIN_DIR}/rfsd"

