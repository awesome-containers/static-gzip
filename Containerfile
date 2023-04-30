# https://github.com/awesome-containers/static-tar
ARG STATIC_TAR_VERSION=1.34
ARG STATIC_TAR_IMAGE=ghcr.io/awesome-containers/static-tar

# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $STATIC_TAR_IMAGE:$STATIC_TAR_VERSION AS static-tar
FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

WORKDIR /src/gzip

# https://git.savannah.gnu.org/cgit/gzip.git
ARG GZIP_VERSION=1.12
RUN set -xeu; \
    curl -#Lo gzip.tar.xz \
        "https://ftp.gnu.org/gnu/gzip/gzip-$GZIP_VERSION.tar.xz"; \
    tar -xvf gzip.tar.xz --strip-components=1; \
    rm -f gzip.tar.xz

ARG CFLAGS='-w -g -Os -static'
# hadolint ignore=SC2044,DL4006
RUN set -xeu; \
    ./configure; \
    make -j"$(nproc)"; \
    mkdir bin; \
    cp gzip bin/; \
    for bin in $(find ./ -executable -maxdepth 1 -type f \( -name 'g*' -o -name 'z*' \)); do \
        file "$bin" -b --mime-type | grep -qw 'text/x-shellscript' || \
            continue; \
        cp "$bin" bin/; \
    done

WORKDIR /src/gzip/bin
RUN set -xeu; \
    strip -s -R .comment --strip-unneeded gzip; \
    ! ldd gzip && :; \
    chmod -cR 755 ./*; \
    chown -cR 0:0 ./*; \
    ./gzip --version; \
    ln -s bash sh

# static gzip image
FROM static-tar
COPY --from=build /src/gzip/bin/ /bin/
