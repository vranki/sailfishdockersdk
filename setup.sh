#!/bin/bash
export PLATFORM_SDK_ROOT=/srv/mer

# tar not installed by default in target
$PLATFORM_SDK_ROOT/sdks/sfossdk/mer-sdk-chroot sudo zypper in -y tar
# Create targets
$PLATFORM_SDK_ROOT/sdks/sfossdk/mer-sdk-chroot sdk-assistant create -y SailfishOS-latest /parentroot/Jolla-latest-Sailfish_SDK_Tooling-i486.tar.bz2
$PLATFORM_SDK_ROOT/sdks/sfossdk/mer-sdk-chroot sdk-assistant create -y SailfishOS-latest-armv7hl /parentroot/Jolla-latest-Sailfish_SDK_Target-armv7hl.tar.bz2

