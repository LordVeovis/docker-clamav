[![](https://img.shields.io/docker/cloud/build/veovis/clamav.svg)](https://hub.docker.com/r/veovis/clamav/builds) [![](https://img.shields.io/docker/pulls/veovis/clamav.svg)](https://hub.docker.com/r/veovis/clamav) ![](https://img.shields.io/microbadger/image-size/veovis%2Fclamav.svg) [![](https://img.shields.io/github/tag/LordVeovis/docker-clamav.svg)](https://github.com/LordVeovis/docker-clamav/tags) [![](https://img.shields.io/github/license/LordVeovis/docker-clamav.svg)](https://github.com/LordVeovis/docker-clamav/blob/master/LICENSE)

# clamAV

An alpine-based docker container providing clamav.

## Details

This container provides clamav.

* Alpine 3.13
* clamav 0.103.2
* clamav-milter 0.103.2

## Installing

See [docker-compose.yml](https://github.com/LordVeovis/docker-clamav/blob/master/docker-compose.yml) for an example of how to configure the container.
Both clamav, freshclam and clamav-milter require a configuration file. If the /etc/clamav is empty, the container provides a suitable default configuration.
Please look at the official [documentation](https://www.clamav.net/documents/configuration) for help on the configuration file.

As all 3 daemons (clamd, freshclam, clamav-milter) are running in separate containers, they cannot use local socket to communicate. Hence, as already included in the default configuration, please configure at least thoses settings :
* /etc/clamav/freshclam.conf:
  * Foreground: MUST be set to yes
* /etc/clamav/clamd.conf:
  * Foreground: MUST be set to yes
  * TCPSocket: MUST be set with a port reachable by freshclam. Ex: TCPSocket 3310
* /etc/clamav/clamav-milter.conf:
  * Foreground: MUST be set to yes
  * MilterSocket: MUST be set to a port reachable by milter clients. Ex: MilterSocket inet:7357
  * ClamdSocket: MUST be set to the hostname and port of clamd. Ex: ClamdSocket tcp:clamav:3310

Please note that if thoses containers are in the same stack, they already share a dedicated network subnet, rendering the port directive in docker-compose useless. In fact, it would be a security weakness.

## Environment variables

* MODE: determine the service to run. The values can be:
  * av: clamd, the anti-virus engine
  * updater: freshclam, it updates the signatures
  * milter: clamav-milter, it provides an interface to milter clients to use clamd
* INITIAL_UPDATE: if 1, it triggers a manual update of the signatures. It should not be very useful except for the very first time when clamd is run before freshclam.

## Ports

* 7357: clamav-milter exposes this TCP port by default for milter clients
* 3310: clamd exposes this TCP port by default for remote control. freshclam uses it to notify clamd the database has been updated

## Contributing

Please read [CONTRIBUTING](https://github.com/LordVeovis/docker-clamav/blob/master/CONTRIBUTING) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

As a packager, we use the same versioning system than the upstream and suffixed by a revision number, like the Gentoo versioning.

* the branch master is the latest version and will be tagged latest
* a git branch represent a specific version from the upstream, like 2.10.3
* a git tag is made from a branched commit and represent a released-tag version frozen in time, like 2.10.3-r2

Usually only the lastest version from the upstream is supported.

## Authors

* **Veovis** - *Initial work* - [LordVeovis](https://github.com/LordVeovis)

## License

This project is licensed under the MPL-2.0 License - see the [LICENSE](https://github.com/LordVeovis/docker-clamav/blob/master/LICENSE) file for details
