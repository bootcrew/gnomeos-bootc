# GNOME OS Bootc!

## Archived

Due to the amazing efforts by the GNOME OS team, this repository is no longer needed now that the upstream GNOME OS OCI
images are bootc compatible.

This image should be what you want to use instead now, make sure to read the GNOME OS documentation for better pointers: `quay.io/gnome_infrastructure/gnome-build-meta:gnomeos-nightly`

See this [Merge Request](https://gitlab.gnome.org/GNOME/gnome-build-meta/-/merge_requests/4256) for the initial bootc support

Special thanks to:
- https://github.com/valentindavid
- https://github.com/alatiera

You two are amazing, thank you so much for working on this.

## Old README

[GNOME's operating system](https://os.gnome.org/) redistributed via bootc!

<img width="2138" height="1332" alt="image" src="https://github.com/user-attachments/assets/51e52947-3819-431d-b24a-4c0691811549" />

## Building

In order to get a running gnomeos-bootc system you can run the following steps:
```shell
just build-containerfile # This will build the containerfile and all the dependencies you need
just generate-bootable-image # Generates a bootable image for you using bootc!
```

Then you can run the `bootable.img` as your boot disk in your preferred hypervisor.
