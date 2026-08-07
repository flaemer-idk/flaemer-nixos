{ config, lib, pkgs, ... }: {

  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraArgs = "-system-composer"; 
      };   
      
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}

