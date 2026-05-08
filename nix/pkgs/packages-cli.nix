{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
git
wget
btop
zapret
home-manager
smartmontools

appimage-run
android-tools
ntfs3g
exfat

fastfetch 
wireplumber

playerctl
brightnessctl

ffmpeg

pciutils
usbutils
lm_sensors

polkit

networkmanager
bluez

vulkan-tools
vulkan-loader
clinfo
radeontop
libva-utils
vdpauinfo
libvdpau-va-gl
libva
];
}
