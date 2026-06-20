{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
#mcomix #i never used this but why i downloading this always i newer used this like app no i hate this app
#libreoffice-qt6
krita
reaper
kdePackages.kdenlive
obsidian 
antimicrox

#snapshot # my webcam is gone gone / thank you and i't newer worked yeah
#qbittorrent # umm bye bye i don't like you
fragments # better torrent maybe 
#paper-plane ##maintein yeah something is gone or something i don't know and no updates yeah
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
