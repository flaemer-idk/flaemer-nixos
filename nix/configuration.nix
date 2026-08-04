{ config, lib, pkgs, ... }: {
  imports = [
    ./Hardware/hardware.nix                    #Base hardware for everyone
    #./Hardware/hardware-pc.nix                 #для пк    
    ./Hardware/hardware-notebook.nix           #для ноута

    ./pkgs/packages-fonts.nix                  #fonts btw
    ./pkgs/packages-cli.nix                    #основные пакеты кли
    ./pkgs/packages.nix                        #основные пакеты

    ./pkgs/Laptop/packages-cli-notebook.nix    #доп пакеты ноут которые не нужны серверу или пк
    ./pkgs/Laptop/packages-notebook.nix        #доп пакеты ноут которые не нужны серверу или пк
    ./Services/notebook-services.nix           #для ноута сервисы которые не нужны или не возможны для других
    #./programs/wayfire.nix                     #Wayfire

    ./Services/Printer.nix                     #принтер 
    ./Services/services.nix                    #ужасные сервисы
    ./Zapret/zapret.nix                        #zapret btw
    ./User/User.nix                            #юзеры
    
    ./programs/programs.nix                    #сам хз зачем нужно
    #./Plasma.nix                               #Kde plasma
    ./fish.nix                                 #Fish for everyone
    ./mango-go.nix
    ./Services/zram.nix                        #Zram патриотическая озу
    ./Services/openssh.nix                     #SSH вот такое да


    #./pkgs/packages-servermaybe.nix            #пакеты серверу
    #./Hardware/hardware-server.nix             #для сервера

    #./Services/Server/Jellyfin.nix             #jellyfin личный
    #./Services/Server/Gonic.nix                #музыка gonic
    #./Services/Server/Photoview.nix            #photoview хочу как личный пинтерест
    #./Services/Server/Memos.nix                #Memos заметки личный
    #./Services/Server/Kavita.nix               #Манго тролфейс
    #./Services/Server/Cockpit.nix		          #Типоуправлять смотреть
    #./Services/Server/
  ];
#virtualisation.docker.enable = true;
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
    supportedFilesystems = [ "nfs" ];
    kernel.sysctl = { "vm.max_map_count" = 262144; };   #For docker umm tubearchivist yeah
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
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
        8040  #хз кто найди его
        5900  # VNC
        7000  # Memos заметки шо 
        8000  # Images
        8080  # Photoview
        8096  # Jellyfin
        9090  # cockpitпанельда
        47984 47989 48010 # Sunshine / Moonlight 
        64989 # хз роблокс вроде да
      ];

      allowedUDPPorts = [
        2005  # хз роблокс вроде да
        5353  # хз роблокс вроде да
        64989 # хз роблокс вроде да
      ];
      allowedUDPPortRanges = [ { from = 47998; to = 48010; } ];
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

  system.stateVersion = "26.05";
}
