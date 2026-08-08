{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.boblox;

  # Окружение Python с необходимыми зависимостями для запуска RFD
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pygobject3
    websocket-client
    requests
    trustme
    urllib3
    pyzstd
    py7zr
    lz4
  ]);
in {
  options.services.boblox = {
    enable = mkEnableOption "Boblox Headless Server (rbxdserver)";

    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ./package.nix {};
      defaultText = literalExpression "pkgs.callPackage ./package.nix {}";
      description = "The rbxdserver package to run.";
    };

    port = mkOption {
      type = types.port;
      default = 8080;
      description = "Port for the HTTP/WS API.";
    };

    placesDir = mkOption {
      type = types.path;
      default = "/Idkselfhost/Roblox/Places";
      description = "Directory where the Roblox places are stored.";
    };

    rfdDir = mkOption {
      type = types.path;
      default = "/Idkselfhost/Roblox/rfd-fork";
      description = "Directory where the unified rfd-fork (containing Source/ and Roblox/) is located.";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/Idkselfhost/Roblox";
      description = "Directory for daemon state, logs, and sessions.";
    };

    tokenFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to the file containing the auth token. If null, the API runs UNPROTECTED.";
    };

    testMode = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to run the server in test mode (disables headless cage rendering).";
    };

    user = mkOption {
      type = types.str;
      default = "boblox";
      description = "User account under which rbxdserver runs.";
    };

    group = mkOption {
      type = types.str;
      default = "boblox";
      description = "Group under which rbxdserver runs.";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to open the API port in the firewall.";
    };

    extraEnv = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Extra environment variables to pass to the rbxdserver service.";
    };
  };

  config = mkIf cfg.enable {
    users.users = mkIf (cfg.user == "boblox") {
      boblox = {
        isSystemUser = true; # Системный пользователь, чтобы не засорять экран входа (Display Manager)
        group = cfg.group;
        shell = pkgs.bash;
        home = "${cfg.dataDir}/boblox"; # Изолированная домашняя папка (/Idkselfhost/Roblox/boblox)
        createHome = true;
        extraGroups = [ "video" "render" "audio" "input" ];
        linger = true;
        description = "Boblox Dedicated Game Server User";
      };
    };

    users.groups = mkIf (cfg.group == "boblox") {
      boblox = {};
    };

    # Настройка прав доступа через системный tmpfiles.rules
    systemd.tmpfiles.rules = [
      # Основные папки создаются с правами 0777, чтобы вы могли легко управлять файлами
      "d ${cfg.dataDir} 0777 ${cfg.user} ${cfg.group} - -"
      "d ${cfg.placesDir} 0777 ${cfg.user} ${cfg.group} - -"
      "d ${cfg.rfdDir} 0777 ${cfg.user} ${cfg.group} - -"
      # Личная домашняя папка пользователя boblox остается более защищенной (0755)
      "d ${cfg.dataDir}/boblox 0755 ${cfg.user} ${cfg.group} - -"
    ];

    systemd.services.boblox = {
      description = "Boblox Headless Server (rbxdserver)";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      # Передаем зависимости сборки и окружения в PATH сервиса
      path = with pkgs; [
        pythonEnv
        cage
        wineWow64Packages.stable
        bash
        coreutils
      ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        WorkingDirectory = cfg.dataDir;
        
        RuntimeDirectory = "boblox";
      
        ExecStart = "${cfg.package}/bin/rbxdserver --port ${toString cfg.port} --rfd ${cfg.rfdDir} --places ${cfg.placesDir} --data-dir ${cfg.dataDir}"
          + (optionalString (cfg.tokenFile != null) " --token-file ${cfg.tokenFile}")
          + (optionalString cfg.testMode " --test");
        
        Restart = "on-failure";
        RestartSec = "5s";
      };

      environment = {
        HOME = "${cfg.dataDir}/boblox"; # Перенаправляем домашний каталог в изолированную подпапку
        SHELL = "${pkgs.bash}/bin/bash";
        
        XDG_RUNTIME_DIR = "/run/boblox";
        XDG_DATA_HOME = "${cfg.dataDir}/boblox/.local/share";
        XDG_CACHE_HOME = "${cfg.dataDir}/boblox/.cache";
        XDG_CONFIG_HOME = "${cfg.dataDir}/boblox/.config";

        LIBSEAT_BACKEND = "noop";             
        WLR_BACKENDS = "headless";            
        WLR_HEADLESS_OUTPUTS = "1";           
        WLR_LIBINPUT_NO_DEVICES = "1";        
        WLR_RENDERER = "pixman";
        
        PYTHONUNBUFFERED = "1";
        
        XDG_SESSION_TYPE = "wayland";
      } // cfg.extraEnv;
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}