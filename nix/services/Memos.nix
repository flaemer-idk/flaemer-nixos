{ config, pkgs, ... }:

{
  services.memos = {
    enable = true;
    settings = {
      MEMOS_PORT = "7000";
      MEMOS_ADDR = "0.0.0.0";
            MEMOS_DATA = "/var/lib/memos"; 
    };
  };
}

