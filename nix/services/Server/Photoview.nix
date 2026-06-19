{ config, pkgs, unstable-pkgs, ... }:

{
  imports = [
    "${unstable-pkgs.path}/nixos/modules/services/web-apps/photoview.nix"
  ];

  services.photoview = {
    enable = true;
    package = unstable-pkgs.photoview;
    host = "0.0.0.0"; 
    port = 8080;
    database = {
      type = "sqlite";
    };
    mediaPath = "/idkselfhost/UmmidkPinterestMaybe"; 
    settings = {
      disableFaceRecognition = false; # пример из твоего списка
      disableVideoEncoding = false;
    };
  };
}
