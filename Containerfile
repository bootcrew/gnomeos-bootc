# Built from https://gitlab.gnome.org/GNOME/gnome-build-meta/-/merge_requests/4256
FROM quay.io/gnome_infrastructure/gnome-build-meta:gnomeos-nightly

RUN bootc container lint || true
