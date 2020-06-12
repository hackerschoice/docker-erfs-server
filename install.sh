#! /bin/bash

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

mv id_rsa-rfs.pub "${RFS_HOME_DIR}/.ssh/authorized_keys"

groupadd rfsusergroup

echo "AcceptEnv THC_RFS_SECRET" >>/etc/ssh/sshd_config
echo "AcceptEnv THC_SSH_PASSWORD" >>/etc/ssh/sshd_config
echo "AcceptEnv THC_RFS_VERSION" >>/etc/ssh/sshd_config
echo "AcceptEnv THC_RFS_TOKEN" >>/etc/ssh/sshd_config
echo "
AllowTcpForwarding no
X11Forwarding no
Match Group rfsusergroup
        ChrootDirectory /mnt/rfs/data/dir-%u
	ForceCommand internal-sftp
	AllowTcpForwarding no
	X11Forwarding no
" >>/etc/ssh/sshd_config

echo "
SUCCESS! Now start your docker instance:

    $ mkdir -p ~/thc-rfs
    $ docker run -it -p 2222:22 --log-driver=none -v ~/thc-rfs:/mnt/rfs thc-rfs-server
"

