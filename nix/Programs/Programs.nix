{ config, lib, pkgs, ... }: {

  programs = {
    chromium.enable = true;
    mtr.enable = true;
    niri.enable = true;
    
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    dconf.enable = true;
  };
}

