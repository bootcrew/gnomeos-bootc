# GNOME OS Bootc!

[GNOME's operating system](https://os.gnome.org/) redistributed via bootc!

## Building

In order to get a running gnomeos-bootc system you can run the following steps:
```shell
just build-containerfile # This will build the containerfile and all the dependencies you need
just generate-bootable-image # Generates a bootable image for you using bootc!
```

Then you can run the `bootable.img` as your boot disk in your preferred hypervisor.
