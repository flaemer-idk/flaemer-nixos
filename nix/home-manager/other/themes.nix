{ pkgs, ... }:

{
  # Жестко фиксируем GTK тему, чтобы Plasma не перехватывала управление
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  # Заставляем Qt-приложения (типа VLC, OBS и т.д.) использовать qt5ct/qt6ct вместо плагинов KDE
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct"; 
  };

  # Добавляем утилиты конфигурации, чтобы если что, докрутить внешний вид руками
  home.packages = with pkgs; [
    qt5ct
    qt6ct
    libsForQt5.breeze-qt5 # если захочешь тему Breeze, но без самой Plasma
    kdePackages.breeze    # для Qt6
  ];
}
