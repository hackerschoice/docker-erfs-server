#! /bin/bash

/etc/init.d/ssh start

RFS_BIN_DIR=`dirname "${0}"`
ROOT_DIR=/mnt/rfs

# Let's store passwd and user data on host...
if [ ! -f "${ROOT_DIR}"/passwd ]; then
	echo "Creating new user database"
	cp -f /etc/passwd "${ROOT_DIR}/"
	cp -f /etc/shadow "${ROOT_DIR}/"
else
	echo "Using existing user database..."
	cp -f ${ROOT_DIR}/passwd /etc/
	cp -f ${ROOT_DIR}/shadow /etc/
fi

[ ! -d "${ROOT_DIR}/data" ] && mkdir "${ROOT_DIR}/data"
echo "Running rfsd...."
"${RFS_BIN_DIR}/rfsd"

