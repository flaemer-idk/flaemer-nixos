{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
nano
btop
ffmpeg
pciutils
lm_sensors
usbutils
libva-utils
vdpauinfo 
libva 
libvdpau-va-gl
smartmontools
];
}
