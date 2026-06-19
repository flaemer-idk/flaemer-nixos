{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware.nix                    #

    ./hardware-pc.nix                 #для пк    
    #./hardware-notebook.nix           #для ноута

    ./pkgs/packages-fonts.nix         #fonts btw
    ./pkgs/packages-cli.nix           #основные пакеты кли
    ./pkgs/packages.nix               #основные пакеты

    #./pkgs/Laptop/packages-cli-notebook.nix  #доп пакеты ноут которые не нужны серверу или пк
    #./pkgs/Laptop/packages-notebook.nix      #доп пакеты ноут которые не нужны серверу или пк
    #./services/notebook-services.nix  #для ноута сервисы которые не нужны или не возможны для других
    #./programs/wayfire.nix

    ./services/printer.nix            #принтер 
    ./services/services.nix           #ужасные сервисы
    ./zapret/zapret.nix               #zapret btw
    ./user/user.nix                   #юзеры
    
    ./programs/programs.nix           #сам хз зачем нужно
    ./Plasma.nix
    ./fish.nix
    ./services/zram.nix               #Zram патриотическая озу
    ./services/openssh.nix            #SSH вот такое да


    #./pkgs/packages-servermaybe.nix   #пакеты серверу
    #./hardware-server.nix             #для сервера
     #./services/Server/jellyfin.nix           #jellyfin личный
    #./services/Server/gonic.nix              #музыка gonic
    #./services/Server/Photoview.nix          #photoview хочу как личный пинтерест
    #./services/Server/Memos.nix              #Memos заметки личный
    #./services/Server/Komga.nix              #Манго тролфейс
  ];

  security.polkit.enable = true;
  fonts.fontDir.enable = true;

  nix = {
    settings.trusted-users = [ "root" "flaemer" ];
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config = {
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    supportedFilesystems = [ "nfs" ];
    kernel.sysctl = { "vm.max_map_count" = 262144; };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
        RADV_PERFTEST = "nggc"; 
          mesa_glthread = "true";
      GDK_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
    };
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
        22    # SSH
        2005  # незнаю roblox?
        4040  # Gonic
        5050  # kavita
        8040
        5900  # VNC
        7000  # Memos заметки шо 
        8000  # Images
        8080  # Photoview
        8096  # Jellyfin
        47984 47989 48010 # Sunshine / Moonlight 
        64989 # хз
      ];

      allowedUDPPorts = [
        2005  # хз
        5353  # хз
        64989 # хз
      ];

      allowedUDPPortRanges = [
        { from = 47998; to = 48010; }
      ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  time = {
    timeZone = "Asia/Krasnoyarsk";
    hardwareClockInLocalTime = true;
 };

#virtualisation.docker.enable = true;
#virtualisation.libvirtd.enable = true;
#programs.virt-manager.enable = true;

  system.stateVersion = "26.05";
}
