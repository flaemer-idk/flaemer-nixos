{ config, pkgs, lib, ... }: {
  services = {
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    displayManager.ly.enable = true;
    flatpak.enable = true;
    blueman.enable = true;

    pipewire = {
      enable = true;
      alsa = { enable = true; support32Bit = true; };
      audio.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;

      extraConfig.pipewire = {
        "92-low-latency".context.properties = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [ 44100 48000 88200 96000 ];
          "default.clock.min-quantum" = 512;
          "default.clock.quantum" = 4096;
          "default.clock.max-quantum" = 8192;
        };
      };
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "Polkit GNOME Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}

