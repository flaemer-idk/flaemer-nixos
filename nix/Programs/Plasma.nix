{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;


  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kpat         # Пасьянс (Solitaire)
    kmahjongg    # Маджонг
    kmines       # Сапер
    ksudoku      # Судоку

    elisa        # Аудиоплеер
    konversation # IRC-клиент
    khelpcenter  # Руководства и справка
    oxygen       # Устаревшие темы оформления
  ];

  # Полезные дополнения для стабильной работы Wayland-окружения
  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm # Модуль для настройки SDDM в системных параметрах KDE
    wayland-utils       # Базовые утилиты диагностики Wayland
  ];
}
