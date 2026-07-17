{ config, pkgs, lib, ... }: {
  services = {
    power-profiles-daemon.enable = false;

    throttled = {
      enable = true;
      extraConfig = ''
        [GENERAL]
        Enabled: True
        Sysfs_Power_Path: /sys/class/power_supply/AC*/online
        Autoreload: True

        [BATTERY]
        Update_Rate_s: 10
        PL1_Tdp_W: 15
        PL1_Duration_s: 28
        PL2_Tdp_W: 25
        PL2_Duration_S: 0.002
        Trip_Temp_C: 85
        Disable_BDPROCHOT: True

        [AC]
        Update_Rate_s: 5
        PL1_Tdp_W: 25
        PL1_Duration_s: 28
        PL2_Tdp_W: 35
        PL2_Duration_S: 0.002
        Trip_Temp_C: 90
        Disable_BDPROCHOT: True

        [UNDERVOLT.BATTERY]
        CORE: -60
        CACHE: -60
        GPU: 0
        UNCORE: 0
        ANALOGIO: 0

        [UNDERVOLT.AC]
        CORE: -60
        CACHE: -60
        GPU: 0
        UNCORE: 0
        ANALOGIO: 0
      '';
    };
    
    # Попробуйте временно отключить thermald, если частота на батарее останется 400МГц
    thermald.enable = true; 

    undervolt.enable = false;
    auto-cpufreq.enable = false;
    upower.enable = true;

tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;

        # 1. Динамическое управление частотой (вместо мертвых статических режимов)
        # Позволяет частоте падать до 400-800 МГц в простое, чтобы дома ноут не грелся.
        # "schedutil" — современный и отзывчивый режим. Если вдруг заметите микрофризы,
        # то замените оба параметра на проверенный "ondemand".
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil"; 
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil"; 

        # 2. Настройка Турбобуста
        # ДОМА (AC): Разрешаем авторазгон, но только на доли секунды при реальной нагрузке.
        # На Ютубе частота будет держаться на минимуме, и ноут будет холодным.
        CPU_BOOST_ON_AC = 1; 

        # НА УЛИЦЕ (BAT): Полностью выключаем турбобуст.
        # Максимальная частота ограничивается базовыми 2.7 ГГц. Отличная производительность без жора батареи.
        CPU_BOOST_ON_BAT = 0; 

        # 3. Энергетическая политика процессора (EPB) для intel_cpufreq
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        # Диапазон работы процессора (в процентах от базовой частоты)
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100; # С отключенным бустом (CPU_BOOST_ON_BAT=0) этого параметра достаточно

        # 4. Энергосбережение остальных компонентов на батарее
        PCIE_ASPM_ON_BAT = "powersave";
        RUNTIME_PM_ON_BAT = "auto";
        USB_AUTOSUSPEND = 1;

        # Экономим батарею на аудиочипе (отключаем питание, если звука нет 1 секунду)
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 1; 
      };
    };
  };
}
