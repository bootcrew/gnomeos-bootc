# Built from https://gitlab.gnome.org/GNOME/gnome-build-meta/-/tree/alatiera/add-kernel-to-image
FROM ghcr.io/alatiera/gnomeos-custom/gnomeos-core:nightly

# https://github.com/bootc-dev/bootc/blob/main/crates/initramfs/dracut/module-setup.sh
RUN --mount=type=tmpfs,dst=/tmp \
    set -x && \
    cp /usr/lib/modules/*/initramfs.img /tmp && \
    mkdir -p /tmp/initramfs && \
    xzcat /tmp/initramfs.img | cpio -idmv -D /tmp/initramfs && \
    install -Dpm0755 /usr/lib/bootc/initramfs-setup /tmp/initramfs/usr/lib/bootc/initramfs-setup && \
    install -Dpm0755 /usr/lib/systemd/system/bootc-root-setup.service /tmp/initramfs/usr/lib/systemd/system && \
    mkdir -p /tmp/initramfs/usr/lib/systemd/system/initrd-root-fs.target.wants && \
    ln -sr ../bootc-root-setup.service /tmp/initramfs/usr/lib/systemd/system/initrd-root-fs.target.wants/bootc-root-setup.service && \
    cd /tmp/initramfs && \
    find . -print0 | sort -z | cpio --reproducible --null -H newc -o --quiet | xz --check=crc32 --lzma2=dict=1MiB > "$(find /usr/lib/modules -maxdepth 1 -type d | tail -n 1)/"initramfs.img

RUN rm -rf /boot/vmlinux /usr/share/doc /usr/libexec/gcc
RUN install -Dpm0755 /boot/* "$(find /usr/lib/modules -maxdepth 1 -type d | tail -n 1)"

RUN rm -rf /boot /home /root /usr/local /srv && \
    mkdir -p /var && \
    ln -s /var/home /home && \
    ln -s /var/roothome /root && \
    ln -s /var/srv /srv && \
    ln -s sysroot/ostree ostree && \
    ln -s /var/usrlocal /usr/local && \
    mkdir -p /sysroot /boot

RUN rm -rf /usr/include /usr/debug

# Necessary for `bootc install`
RUN mkdir -p /usr/lib/ostree && \
    printf "[composefs]\nenabled = yes\n[sysroot]\nreadonly = true\n" | \
    tee "/usr/lib/ostree/prepare-root.conf"

RUN sed -i 's|^HOME=.*|HOME=/var/home|' "/etc/default/useradd"

# Also make sure to create a root password by doing `init=/sbin/bash` or setting this on the containerfile when building locally.
# RUN echo 'root:HASH_THAT_YOU_WANT:20311:0:99999:7:::' | tee /etc/shadow

RUN bootc container lint || true
