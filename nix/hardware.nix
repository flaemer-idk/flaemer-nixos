{ config, lib, pkgs, ... }: {
  hardware = {
    i2c.enable = true;
    uinput.enable = true;
    enableRedistributableFirmware = true;
    steam-hardware.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ mesa mesa-demos ];
    };
    bluetooth = {
      package = pkgs.bluez;
      powerOnBoot = true;
      enable = true;
      settings = { 
        General = {
          ClassicBondedOnly = false;
          Enable = "Source,Sink,Media,Socket,Input";
          UserspaceHID = true;
        }; 
      };
    };
  };
}