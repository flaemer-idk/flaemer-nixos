{ config, pkgs, lib, ... }: {
  services.gonic = {
    enable = true;
    settings = {
      music-path = [ "/idkselfhost/Music" ];
      podcast-path = [ "/var/lib/gonic/podcasts" ];
      playlists-path = [ "/var/lib/gonic/playlists" ];
      cache-path = "/var/lib/gonic/cache";
      listen-addr = "0.0.0.0:4040";
    };
  };

  # Прописываем создание подпапок поверх дефолтных настроек модуля
  systemd.services.gonic.serviceConfig = {
    StateDirectory = lib.mkForce "gonic gonic/cache gonic/playlists gonic/podcasts";
    ReadWritePaths = [ "/var/lib/gonic" ];
  };
}
