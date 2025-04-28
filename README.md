<div align="center">
    <picture>
        <source srcset="https://github.com/user-attachments/assets/5b655bcb-f529-4580-ad43-607b11cf5a1b" media="(prefers-color-scheme: dark)">
        <img src="https://github.com/user-attachments/assets/fd7a35df-5ac9-4605-8f0c-5ad565f5f5bf">
    </picture>
    <a href="https://github.com/tulilirockz/papermache/actions/workflows/paper-image.yml"><img src="https://github.com/tulilirockz/papermache/actions/workflows/paper-image.yml/badge.svg" alt="Build Status" /></a>
    <a href="https://github.com/tulilirockz/papermache/main/LICENSE.md"><img src="https://img.shields.io/github/license/atomic-studio-org/Atomic-Studio?style=plastic&style=social" alt="Image License: APACHE 2.0"/></a>
</div>
<hr/>

Some actually pretty good PaperMC OCI images.

These images are built with Chainguard's
[apko/melange](https://edu.chainguard.dev/open-source/build-tools/melange/getting-started-with-melange/)
tooling, based on [Wolfi](https://github.com/wolfi-dev). We provide SBOMs,
proper signing, and a very minimal container so your runtime isnt cluttered by
vulnerabilities. This is also meant to have a very tight scope, we dont want to
manage your minecraft server installation at all, just deliver you a secure container.

Just know that sadly these builds are very much non deterministic due to
Paper's nature of patching official JARs straight from Mojang

## Motivation

I mostly just thought this would be a cool project to make, after watching
[Chainguard's video on Minecraft Servers](https://www.youtube.com/watch?v=q6I0JC3h06U)
I just got curious to see if I could do this with PaperMC, then I saw there wasnt
anything similar to this in the wild, so I made this project!

## TODO
- [ ] Templating for multiple PaperMC versions
- [ ] Folia package
- [ ] Use Renovate for everything

## Usage

```bash
podman run --rm -it -v minecraft:/data:Z -p 25565:25565 ghcr.io/tulilirockz/paper:latest
```

You can also use this as a compose:
```yaml
services:
  paper:
    image: ghcr.io/tulilirockz/paper:1.24.1
    ports:
      - 25565:25565
    volumes:
      - minecraft:/data:Z
volumes:
  minecraft:
```

## Building locally

```bash
just build (package)
# This will also import the image to your storage if you want
just build-container (package) # (import or not w/ 1/0)
```

## Verifying authenticity

Our claims about security don't make sense at all if you cant verify them.
Here are a few methods:

### Cosign Key

This way you can actually know if I made this image or not.
Allows you to know if the image has been tampered with

```bash
cosign verify \
 --key https://raw.githubusercontent.com/tulilirockz/papermache/refs/heads/main/cosign.pub \
  "ghcr.io/tulilirockz/paper:latest"
```

### Fetch SBOM

This returns you the [Software Bill of Materials](https://www.cisa.gov/sbom)
for these images, a list of pretty much everything in it.

```bash
cosign verify-attestation \
  --key https://raw.githubusercontent.com/tulilirockz/papermache/refs/heads/main/cosign.pub \
  --type https://spdx.dev/Document \
  "ghcr.io/tulilirockz/paper:latest" | jq -r .payload | base64 -d | jq .predicate > ./paper-sbom.yaml
```

### Scanning for Vulnerabilities and Verifying contents

[Grype](https://github.com/anchore/grype) and [Dive](https://github.com/wagoodman/dive)
are great tools for verifying what you got is safe

```bash
# This will analyze the image and check for vulnerabilities
# Any vulnerability here is a combination of Wolfi's vulnerabilities, openJDKs, and PaperMCs
grype ghcr.io/tulilirockz/paper:latest

# This allows you to know what even is on the image, before executing
dive ghcr.io/tulilirockz/paper:latest
```

# NOTE

This project is not affiliated with Mojang, Microsoft, Chainguard, Oracle and
is redistributed following the Apache 2.0 license with no warranty or liability
