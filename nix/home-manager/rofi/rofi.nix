{ config, pkgs, lib, ... }:{
  programs.rofi = {
    enable = true;
    theme = "hi"; 
  };
  xdg.configFile = {
    "rofi/themes/hi.rasi".source = ./rofi.rasi;
  };
}
