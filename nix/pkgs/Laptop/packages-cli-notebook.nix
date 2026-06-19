{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
wirelesstools
yt-dlp
nix-prefetch-github
];
}
