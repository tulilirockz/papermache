build $package="":
    podman run \
        --rm -it -v "${PWD}:/work:Z" --privileged \
        cgr.dev/chainguard/melange build "packages/${package}.yaml" --signing-key melange.rsa --arch host

build-container $package="" $import="1":
    #!/usr/bin/env bash
    podman run \
        --rm -it --workdir /work -v "${PWD}:/work:Z" \
        cgr.dev/chainguard/apko build "containers/${package}.yaml" "${package}:latest" "${package}.tar" --arch host

    if [ "${import}" == "1" ] ; then
        podman load < "${package}.tar"
    fi
