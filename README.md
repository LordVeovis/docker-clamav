[![](https://img.shields.io/docker/pulls/veovis/clamav.svg)](https://hub.docker.com/r/veovis/clamav) ![](https://img.shields.io/microbadger/image-size/veovis%2Fclamav.svg) [![](https://img.shields.io/github/tag/LordVeovis/docker-clamav.svg)](https://github.com/LordVeovis/docker-clamav/tags) [![](https://img.shields.io/github/license/LordVeovis/docker-clamav.svg)](https://github.com/LordVeovis/docker-clamav/blob/master/LICENSE)

# clamAV

An alpine-based docker container providing clamav.

## Details

This container provides clamav.

* Alpine 3.8.2
* clamav 0.100.2

## Installing

See [docker-compose.yml](https://github.com/LordVeovis/docker-clamav/blob/master/docker-compose.yml) for an example of how to configure the container.
clamav require a configuration file that MUST be mapped to /etc/clamav/clamd.conf, as indicated on the [docker-compose.yml](https://github.com/LordVeovis/docker-clamav/blob/master/docker-compose.yml).
Please look at the official [documentation](https://www.clamav.net/documents/configuration) for help on the configuration file.

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
