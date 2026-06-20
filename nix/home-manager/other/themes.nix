{ pkgs, ... }: {
  # Включаем dconf, без него libadwaita/GTK4 в не-GNOME окружениях игнорирует темную тему
  dconf.enable = true;

  gtk = {
    enable = true;

    # adw-gtk3-dark сделает ТЕМНЫМИ старые GTK3 приложения (типа REAPER, LMMS, Inkscape)
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
    };

    # Принудительно заставляем старый софт темнеть
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Это САМЫЙ важный блок. Он включает нативную темную Libadwaita для всего нового софта (GTK4)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      icon-theme = "MoreWaita";
    };
  };
}

