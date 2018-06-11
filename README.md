# Sailfish OS SDK in Docker container

SailfishOS development environment in Docker. *Still experimental, feel free to make PR's*

## Usage

### First time setup

1. Build image:

  `docker build -t sailfishsdk .`

2. Run setup:

  `docker run --name sailfishsdk-setup -it --privileged sailfishsdk /setup.sh`

3. Store the current state as a new image:

  `docker commit sailfishsdk-setup sailfishsdk:setup`

### Using the container

To build helloworld-pro-sailfish as an example:

1. Enter the SDK

  `docker run --name sailfishsdk -it --privileged sailfishsdk:setup /srv/mer/sdks/sfossdk/mer-sdk-chroot`

2. Clone and build
```bash
cd /home/docker
git clone https://github.com/amarchen/helloworld-pro-sailfish.git
cd helloworld-pro-sailfish
mb2 -t SailfishOS-latest-armv7hl build
```
*TODO: The build fails, why?*

3. If you exit the container, you can re-enter it with

  `docker start -ai /sailfishsdk`

## Hints

To install packages in target, use:
`sb2 -t SailfishOS-latest-armv7hl -m sdk-install -R zypper in ...`

## Known issues

* The SDK refuses to install in unprivileged container. Docker build can't be run
in one so the setup must be done as a separate step. Any workarounds for this?
* Build of helloworld-pro fails. Why is this?
