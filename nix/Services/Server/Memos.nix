{ config, pkgs, ... }:

{
  disabledModules = [ "services/misc/memos.nix" ];

  imports = [
    ./Custom/Memos/module.nix
  ];

  services.memos = {
    enable = true;
    port = 7000;
    openFirewall = true;

    settings = {
      MEMOS_PORT = "7000";
      MEMOS_ADDR = "0.0.0.0";
      MEMOS_DATA = "/var/lib/memos"; 
      
      #MEMOS_INSTANCE_URL = "http://192.168.0.100:7000"; # поставька короче если захочеь public и без входа в акк смотреть на public
    };
  };
}