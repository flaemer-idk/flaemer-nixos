{ config, pkgs, lib, ... }:

{
  xdg.configFile = {
    "niri/config.kdl".source = ./config.kdl;
    "niri/window-focus.kdl".source = ./window-focus.kdl;
  };
}
