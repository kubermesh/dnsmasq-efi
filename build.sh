#!/bin/sh
set -eux pipefail

GIT_TAG=26050fd4c87c50503d5bd573b2ec91703676e211

if [ ! -d ipxe ]; then
  git clone http://git.ipxe.org/ipxe.git
fi

cd ipxe
  git reset --hard ${GIT_TAG}
cd -

sed -i 's/#undef\tNET_PROTO_IPV6/#define\tNET_PROTO_IPV6/' ipxe/src/config/general.h
make -j 8 -C ${PWD}/ipxe/src/ bin-x86_64-efi/ipxe.efi

cp ipxe/src/bin-x86_64-efi/ipxe.efi docker/

IMAGE=kubermesh/tftp-ipxe:${GIT_TAG}
docker build -t ${IMAGE} docker
docker push ${IMAGE}

echo Built image: ${IMAGE}
