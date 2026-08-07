{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.mango-go;
in {
  options.services.mango-go = {
    enable = mkEnableOption "Mango-Go manga server";

    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ./package.nix {};
      description = "The mango-go package to run.";
    };

    port = mkOption {
      type = types.port;
      default = 8080;
      description = "Port the mango-go web server will listen on.";
    };

    libraryPath = mkOption {
      type = types.path;
      default = "/var/lib/mango-go/manga";
      description = "Path to the manga library folder.";
    };

    databasePath = mkOption {
      type = types.str;
      default = "/var/lib/mango-go/mango.db";
      description = "Path to the SQLite database file.";
    };

    pluginsPath = mkOption {
      type = types.path;
      default = "/var/lib/mango-go/plugins";
      description = "Path to the plugins directory.";
    };

    scanInterval = mkOption {
      type = types.int;
      default = 30;
      description = "Library scan interval in minutes.";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Open the firewall port for mango-go.";
    };

    user = mkOption {
      type = types.str;
      default = "mango";
      description = "User account under which mango-go runs.";
    };

    group = mkOption {
      type = types.str;
      default = "mango";
      description = "Group account under which mango-go runs.";
    };

    extraEnv = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Extra environment variables to pass to the service.";
    };
  };

  config = mkIf cfg.enable {
    # Создание системного пользователя и группы
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      description = "Mango-Go daemon user";
      home = "/var/lib/mango-go";
    };

    users.groups.${cfg.group} = {};

    # Открытие портов в фаерволе
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];

    # Описание Systemd-сервиса
    systemd.services.mango-go = {
      description = "Mango-Go Manga Server and Web Reader";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      # Нам понадобятся утилиты для работы с архивами во время чтения/распаковки manga-go
      path = with pkgs; [
        p7zip
        unrar
        unzip
      ];

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/mango-go";
        User = cfg.user;
        Group = cfg.group;
        Restart = "on-failure";

        # Автоматическое создание рабочей директории в /var/lib/mango-go
        StateDirectory = "mango-go";
        WorkingDirectory = "/var/lib/mango-go";

        # Конфигурация через переменные окружения
        Environment = [
          "MANGO_PORT=${toString cfg.port}"
          "MANGO_LIBRARY_PATH=${cfg.libraryPath}"
          "MANGO_DATABASE_PATH=${cfg.databasePath}"
          "MANGO_PLUGINS_PATH=${cfg.pluginsPath}"
          "MANGO_SCAN_INTERVAL=${toString cfg.scanInterval}"
        ] ++ mapAttrsToList (n: v: "${n}=${v}") cfg.extraEnv;

        # Песочница Systemd (Безопасность)
        ProtectSystem = "strict";
        ProtectHome = "read-only"; # Позволяет читать из /home, если манга хранится у пользователя
        PrivateTmp = true;
        NoNewPrivileges = true;

        # Разрешаем запись только в необходимые директории (база данных, плагины и сама библиотека для загрузок)
        ReadWritePaths = [
          "/var/lib/mango-go"
          cfg.libraryPath
          (dirOf cfg.databasePath)
          cfg.pluginsPath
        ];
      };
    };
  };
}
