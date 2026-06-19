{ config, pkgs, ... }: {
  home = {
    username = "flaemer";
    homeDirectory = "/home/flaemer";
    stateVersion = "26.05";
  }; 
          
  imports = [
#    ./home-manager/niri/config.nix
    ./home-manager/other/kitty.nix
    ./home-manager/other/fastfetch.nix
    ./home-manager/other/themes.nix
    ./home-manager/other/mangohud.nix
    ./home-manager/rofi/rofi.nix
    ./home-manager/eww/eww.nix

#    ./home-manager/desktop/AdoptMe.nix
#    ./home-manager/desktop/Gearworks.nix	
  ];
}
