# GNOME OS Bootc!

[GNOME's operating system](https://os.gnome.org/) redistributed via bootc!

<img width="2138" height="1332" alt="image" src="https://github.com/user-attachments/assets/51e52947-3819-431d-b24a-4c0691811549" />

## Building

In order to get a running gnomeos-bootc system you can run the following steps:
```shell
just build-containerfile # This will build the containerfile and all the dependencies you need
just generate-bootable-image # Generates a bootable image for you using bootc!
```

Then you can run the `bootable.img` as your boot disk in your preferred hypervisor.
