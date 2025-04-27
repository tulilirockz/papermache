# PaperMache

Some actually pretty good PaperMC OCI images.

![Finally some good food](https://64.media.tumblr.com/e02c5bfb47338a49e6e9228475869fc7/tumblr_pah89p3xWV1tn6k7ro1_1280.pnj)
<sub>(Art made by [midori-n](https://www.tumblr.com/midori-n) on Tumblr)</sub>

These images are built with Chainguard's
[apko/melange](https://edu.chainguard.dev/open-source/build-tools/melange/getting-started-with-melange/)
tooling, based on [Wolfi](https://github.com/wolfi-dev). We provide SBOMs,
proper signing, and a very minimal container so your runtime isnt cluttered by
vulnerabilities.

Just know that sadly these builds are very much non deterministic due to
Paper's nature of patching official JARs straight from Mojang

## Motivation

I mostly just thought this would be a cool project to make, after watching
[Chainguard's video on Minecraft Servers](https://www.youtube.com/watch?v=q6I0JC3h06U)
I just got curious to see if I could do this with PaperMC, then I saw there wasnt
anything similar to this in the wild, so I made this project!

## TODO
- [ ] Templating for multiple PaperMC versions
- [ ] Folia package?
- [ ] Working! workflows


## Usage

```bash
podman run --rm -it -v "your-server-volume:/data:Z" ghcr.io/tulilirockz/paper:1.24.1

```

You can also use this as a compose:
```yaml
blah:

```

## Building locally
```bash
just build (package)
# This will also import the image to your storage if you want
just build-container (package) # (import or not w/ 1/0)
```

# NOTE

This project is not affiliated with Mojang, Microsoft, Chainguard, Oracle and
is redistributed following the Apache 2.0 license with no warranty or liability
