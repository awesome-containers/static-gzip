# Statically linked Gzip

Statically linked [Gzip] container image with [Bash] and [Tar]

> 1,9M (1,7M bash + tar)

```bash
ghcr.io/awesome-containers/static-gzip:latest
ghcr.io/awesome-containers/static-gzip:1.12

docker.io/awesomecontainers/static-gzip:latest
docker.io/awesomecontainers/static-gzip:1.12
```

Slim statically linked [Gzip] container image with [Bash] and [Tar]
packaged with [UPX]

> 1,1M (950K bash + tar)

```bash
ghcr.io/awesome-containers/static-gzip:latest-slim
ghcr.io/awesome-containers/static-gzip:1.12-slim

docker.io/awesomecontainers/static-gzip:latest-slim
docker.io/awesomecontainers/static-gzip:1.12-slim
```

[Gzip]: https://www.gnu.org/software/gzip/
[Bash]: https://github.com/awesome-containers/static-bash
[Tar]: https://github.com/awesome-containers/static-tar
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_GZIP_IMAGE="$image" \
  --build-arg STATIC_GZIP_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
