{ config, lib, pkgs, ... }: {

programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wf-shell   # Панель и обои
      wayfire-plugins-extra
    ];
  };
}
