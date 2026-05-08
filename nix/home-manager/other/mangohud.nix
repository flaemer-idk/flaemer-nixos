{ config, pkgs, ... }: {
  programs.mangohud = {
    enable = true;
    settings = {
      legacy_layout = false;
      position = "top-left";
      swap = true;
      ram = true;
      cpu_stats = true;
      cpu_temp = true;
      cpu_name = true;
      vram = true;
      gpu_stats = true;
      gpu_temp = true;
      gpu_name = true;
      fps = true;
      frame_timing = 1;
      background_alpha = "0.4";
    };
  };
}
