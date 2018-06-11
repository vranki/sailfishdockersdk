

#
# SailfishOS development environment in Docker
#


FROM debian:stable-slim

RUN apt update
RUN apt install -y curl bzip2 sudo

ENV PLATFORM_SDK_ROOT /srv/mer

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# For testing the container, you may want to download the files here and just copy them to
# container. Comment out the curl lines below if so.
#COPY Jolla-latest-SailfishOS_Platform_SDK_Chroot-i486.tar.bz2 /
#COPY Jolla-latest-Sailfish_SDK_Target-armv7hl.tar.bz2 /
#COPY Jolla-latest-Sailfish_SDK_Tooling-i486.tar.bz2 /

RUN curl -k -O http://releases.sailfishos.org/sdk/installers/latest/Jolla-latest-SailfishOS_Platform_SDK_Chroot-i486.tar.bz2
RUN curl -k -O http://releases.sailfishos.org/sdk/latest/Jolla-latest-Sailfish_SDK_Target-armv7hl.tar.bz2
RUN curl -k -O http://releases.sailfishos.org/sdk/latest/Jolla-latest-Sailfish_SDK_Tooling-i486.tar.bz2

COPY setup.sh /

RUN chmod a+rx /setup.sh

USER docker

RUN sudo mkdir -p $PLATFORM_SDK_ROOT/sdks/sfossdk /srv/mer/targets /srv/mer/toolings
RUN sudo tar --numeric-owner -p -xjf Jolla-latest-SailfishOS_Platform_SDK_Chroot-i486.tar.bz2 -C $PLATFORM_SDK_ROOT/sdks/sfossdk
RUN echo "export PLATFORM_SDK_ROOT=$PLATFORM_SDK_ROOT" >> ~/.bashrc
RUN echo 'alias sfossdk=$PLATFORM_SDK_ROOT/sdks/sfossdk/mer-sdk-chroot' >> ~/.bashrc
RUN echo 'PS1="PlatformSDK $PS1"' > ~/.mersdk.profile
RUN echo '[ -d /etc/bash_completion.d ] && for i in /etc/bash_completion.d/*;do . $i;done'  >> ~/.mersdk.profile 

