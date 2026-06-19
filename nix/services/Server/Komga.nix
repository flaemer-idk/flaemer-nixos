{ config, pkgs, lib, ... }: {
  services.komga = {
    enable = true;
    port = 8040;
  };
}
