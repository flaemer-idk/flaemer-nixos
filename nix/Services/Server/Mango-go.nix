{ config, pkgs, ... }:

{
  imports = [
    ./Custom/Mango-go/module.nix
  ];

services.mango-go = {
  enable = true;
  port = 8080;

  libraryPath = "/idkselfhost/Mango/Manga";
  databasePath = "/idkselfhost/Mango/data/mango.db";
  pluginsPath = "/idkselfhost/Mango/plugins";

  openFirewall = true;
};
}
