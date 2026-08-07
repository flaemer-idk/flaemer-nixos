{ config, pkgs, ... }:

{
  imports = [
    ./Custom/Boblox/module.nix
  ];

services.boblox = {
  enable = true;
  port = 8080;
  openFirewall = true;
  
  rfdDir = "/idkselfhost/Roblox/rfd-fork";
  placesDir = "/idkselfhost/Roblox/Places";
  dataDir = "/idkselfhost/Roblox";
  #wine-path = "/idkselfhost/Roblox/data/wine/.wine-rfd"; #wine-path maybe i should add this

};
}