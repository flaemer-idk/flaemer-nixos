{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
mcomix
#libreoffice-qt6
krita
lmms
kdePackages.kdenlive
obsidian
antimicrox

snapshot
qbittorrent
#paper-plane
kid3
simple-scan
sane-backends

qemu
moonlight-qt

intel-gpu-tools
intel-compute-runtime
intel-media-driver

vscodium
hydrus
python3

scrcpy
localsend
godot_4
gnome-clocks
appstream
luajit
  ddcutil
  ddcui
  tldr
  cheat
  file
  eza
  ripgrep
  fd
  imv
];
}
