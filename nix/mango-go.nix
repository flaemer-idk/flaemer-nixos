{ config, pkgs, ... }:

{
  imports = [
    ./module.nix
  ];

services.mango-go = {
  enable = true;
  port = 8080; # Или любой порт на ваш выбор

  # Пути, перенесенные из Docker
  libraryPath = "/idkselfhost/mango/manga";
  databasePath = "/idkselfhost/mango/data/mango.db";
  pluginsPath = "/idkselfhost/mango/plugins";

  openFirewall = true; # Открыть порт 8080 в фаерволе системы
};
}
