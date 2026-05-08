{ config, lib, pkgs, ... }:{
imports =
    [
      #./hardware-pc.nix                 #для пк    
      ./hardware-notebook.nix           #для ноута
      
      ./pkgs/packages-fonts.nix         #fonts btw
      ./pkgs/packages-cli.nix           #основные пакеты кли
      ./pkgs/packages.nix               #основные пакеты
      
      ./pkgs/packages-cli-notebook.nix  #доп пакеты ноут которые не нужны серверу или пк
      ./pkgs/packages-notebook.nix      #доп пакеты ноут которые не нужны серверу или пк
      ./services/notebook-services.nix  #для ноута сервисы которые не нужны или не возможны для других
      #./programs/wayfire.nix
      
      ./services/printer.nix            #принтер 
      ./services/services.nix           #ужасные сервисы
      ./zapret/zapret.nix               #zapret btw
      ./user/user.nix                   #юзеры
      ./programs/programs.nix           #сам хз зачем нужно

      ./services/zram.nix               #Zram патриотическая озу
      ./services/openssh.nix            #SSH вот такое да
      
      #./pkgs/packages-servermaybe.nix   #пакеты серверу
      #./hardware-server.nix             #для сервера
      #./services/jellyfin.nix           #jellyfin личный я хз нетфликс я хз я ниче такого не юзал из сервисов для фильмов
      #./services/gonic.nix              #музыка gonic вот дааа
      #./services/Photoview.nix          #photoview хочу как личный пинтерест
    ];
    
 #services.rpcbind.enable = true;        #Nfs вот да
 #virtualisation.waydroid.enable = true; #Waydorid вот да настоящий                                                                                                                                                                                                                                                                                                                                              #maybe idk i don't need this because it's loading long and tiktok working im lazy i dont need but you can be here because i allow this because i can't make normal config i need did something where is bloat like that other .nix file but i too lazy to make other .nix file and i need loggin in to github or something maybe use usb flash or other disk or local server yea i need make local server for files like videos or this because i don't will need github because i don't have peoples who will fix my config or help and i don't need this is my config ya dolboyob i need stop write
  security.polkit.enable = true;
  fonts.fontDir.enable = true;
  kernelPackages = pkgs.linuxPackages_latest;

#services.journald.extraConfig = "
#    Storage=persistent
#    Compress=yes
#    MaxLevelStore=notice
#";
  
nix = {
    settings.trusted-users = [ "root" "flaemer" ];
    settings.experimental-features = [ "nix-command" "flakes"];
#    settings.auto-optimise-store = false;
};

nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config = {
      allowUnsupportedSystem = true;
      allowUnfree = true;
    }
}

boot = {
  supportedFilesystems = [ "nfs" ];
  loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
};

environment = {
    sessionVariables = {
        NIXOS_OZONE_WL = "1"; 
        GDK_BACKEND = "wayland"; 
        SDL_VIDEODRIVER = "wayland"; 
    variables = {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
   };
};

networking = {
    hostName = "nixos"; 
    networkmanager.enable = true;  
    networkmanager.dns = "none";  
    nameservers = [
        "185.37.37.37" 
        "185.37.39.39"
      ];
    firewall = {
        enable = true; 
        allowedTCPPorts = [ 
          22        # SSH
          4040      # Gonic
          8000      # Images
          8080      # Photoview
          5900      # VNC
          47984 47989 48010 # Sunshine / Moonlight 
          8096      # Jellyfin 
          60827     # soulseek
          60828     # soulseek
          2005      #незнаю
          64989     #хз
        ];

        allowedUDPPorts = [ 
          5353      #хз
          2005      #хз
          64989     #хз
        ]; 
        
        allowedUDPPortRanges = [
            { from = 47998; to = 48010; }
        ]; }; };

hardware = {
    enableRedistributableFirmware = true;
    graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [ mesa mesa-demos ];
       };
    bluetooth = {
        powerOnBoot = true;
        enable = true;
    };
};
    
xdg.portal = { 
    enable = true;
    extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
    ];
};  

 system.stateVersion = "25.11"; # Did you read the comment?
}

