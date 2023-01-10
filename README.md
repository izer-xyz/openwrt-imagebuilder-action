# openwrt-imagebuilder-action

Build and [OpenWrt](https://openwrt.org) firmware image using [Imagebuilder](https://openwrt.org/docs/guide-user/additional-software/imagebuilder).

# Usage

See [action.yml](action.yml)

Parameters

 * `profile`: bcm27xx-bcm2711
 * `openwrt-version`: 22.03.2
 * `packages`: -ppp 
 * `files`: test/files
 * `disabled-services`: dhcp
 * `extra-image-name`: useless

Outputs

 * *`./bin/targets/**`*
   * e.g. `./bin/targets/bcm27xx/bcm2711/openwrt-22.03.2-useless-bcm27xx-bcm2711-rpi-4-squashfs-factory.img.gz`

An example producing a none working image:

 * [.github/workflows/test.yml](.github/workflows/test.yml)

### Build a firmware image without ppp package

```yaml
steps:
- uses: izer-xyz/openwrt-imagebuilder-action@main
  with:
    profile: bcm27xx-bcm2711
    openwrt-version: 22.03.2
    packages: -ppp 
```

### Add custom files

```yaml
steps:
- uses: izer-xyz/openwrt-imagebuilder-action@main
  with:
    profile: bcm27xx-bcm2711
    openwrt-version: 22.03.2
    files: test/files
```

# FAQ

### How to find `profile` and `openwrt-version`

The Docker Hub [Imagebuilder tags](https://hub.docker.com/r/openwrtorg/imagebuilder/tags) are formatted `${profile}-${openwrt-version}`. E.g.

  * [*bcm27xx-bcm2711*-**22.03.2**](https://hub.docker.com/layers/openwrtorg/imagebuilder/bcm27xx-bcm2711-22.03.2/)
    * `profile`: *bcm27xx-bcm2711*
    * `openwrt-version`: **22.03.2**

## Additional Documentation

 * 

# License

The scripts and documentation in this project are released under the [MIT License](LICENSE).
