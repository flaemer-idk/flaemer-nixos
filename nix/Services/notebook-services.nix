{ config, pkgs, lib, ... }: {
  services = {
    power-profiles-daemon.enable = false;
    throttled = {
      enable = true;
    };

    undervolt = {
      enable = true;
      coreOffset = -95;
      gpuOffset = -60;
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    
    thermald.enable = false;
  };
}
