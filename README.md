weboob
=========

Docker container to run weboob (http://weboob.org/)

This container is based on edausq/weboob :
* I added the mupdf-tools package that is needed (at least) for the french bank AXA Banque.
* I switched to the stable channel

## Basic usage

Launch the container via docker:
```
docker run -ti --rm \
                -v /srv/docker/weboob-config:/config \
                -v /srv/docker/weboob-data:/data \
                thomfab/docker-weboob \
                weboob

```

This will launch the main weboob interface where you choose a service and configure it.

## Bank usage

You can also directly launch the boobank script.

To get the list of bank account configured :
```
docker run -ti --rm \
                -v /srv/docker/weboob-config:/config \
                -v /srv/docker/weboob-data:/data \
                thomfab/docker-weboob \
                boobank list

```

See : http://weboob.org/applications/boobank for more information.
