{ config, pkgs, lib, ... }: {
  services = {
    printing.enable = true;
    printing.webInterface = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;      
      openFirewall = true; 
          publish = {
      enable = true;
      userServices = true;
    };
  };

    printing.drivers = [
      pkgs.brlaser
      pkgs.gutenprint 
    ];
  };
}

