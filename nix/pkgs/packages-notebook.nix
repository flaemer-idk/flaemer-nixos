{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
mcomix
libreoffice-qt6
krita
lmms
kdePackages.kdenlive

snapshot
qbittorrent
paper-plane
kid3
simple-scan
sane-backends

qemu
moonlight-qt

intel-gpu-tools
intel-compute-runtime
intel-media-driver

  meson
  ninja
  vala
  pkg-config
  gtk4
  libadwaita
  gobject-introspection
  desktop-file-utils
  gst_all_1.gstreamer
  gst_all_1.gst-plugins-base
  gst_all_1.gst-plugins-good
  gst_all_1.gst-plugins-bad

];
}
