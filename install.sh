#! /bin/bash

# Install required packages
# apt-get update -y

THC_DOCKER_VERSION="`cat /THC-DOCKER-VERSION`"

# Make sure we are on a docker instance...
if [ x"${THC_DOCKER_VERSION}" != x1.1 ]; then
	echo "Oops. This does not appear to be a THC RFS docker instance"
	exit -1
fi

RFS_INIT_USER="rfs-init"
RFS_ROOT_DIR="/mnt/rfs"
RFS_HOME_DIR="/home/${RFS_INIT_USER}"
RFS_BIN_DIR="/thc-bin"

useradd "${RFS_INIT_USER}" -s "${RFS_BIN_DIR}/rfssh"
mkdir "${RFS_HOME_DIR}"
touch "${RFS_HOME_DIR}/.hushlogin"
mkdir "${RFS_HOME_DIR}/.ssh"

cp id_rsa-rfs.pub "${RFS_HOME_DIR}/.ssh/authorized_keys"

groupadd rfsusergroup

echo "AcceptEnv THC_RFS_SECRET" >>/etc/ssh/sshd_config
echo "AcceptEnv THC_SSH_PASSWORD" >>/etc/ssh/sshd_config
echo "
AllowTcpForwarding no
X11Forwarding no
Match Group rfsusergroup
        ChrootDirectory /mnt/rfs/data/dir-%u
	ForceCommand internal-sftp
	AllowTcpForwarding no
	X11Forwarding no
" >>/etc/ssh/sshd_config

mkdir -p "${RFS_BIN_DIR}"
cp start.sh rfsd rfssh "${RFS_BIN_DIR}"

echo "
SUCCESS! Now start your docker instance:

    [ ! -d ~/thc/-rfs ] && mkdir ~/thc-rfs
    docker run -it -p 2222:22 -v ~/thc-rfs:/mnt/rfs thc-rfs:latest bash -c ${RFS_BIN_DIR}/start.sh
"

#docker run --name thc-rfs -it 2222:22 -v ~/thc-rfs:/mnt/rfs ubuntu:18.04 bash -c ${RFS_ROOT_DIR}/bin/start.sh
