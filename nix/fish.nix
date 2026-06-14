{ config, pkgs, ... }: {

  # 1. Включаем Fish на уровне системы
  programs.fish.enable = true;

  # 2. Делаем Fish дефолтной оболочкой для вашего пользователя и для root
  users.users.flaemer = {
    isNormalUser = true;
    shell = pkgs.fish;
    # ваши остальные настройки (extraGroups и т.д.)
  };

  users.users.root = {
    shell = pkgs.fish;
  };

  # 3. Глобальные алиасы для ВСЕХ (включая root)
  # Вместо жесткого пути /home/flaemer используем $HOME, чтобы у root всё не ломалось
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/flaemer/nix#nixos"; 
    home-switch = "home-manager switch --flake $HOME/nix"; 
    nix-clean = "sudo nix-collect-garbage -d"; 
    nix-shell = "nix-shell -p"; 
    nixos-update = "sudo nixos-rebuild switch --upgrade"; 
    nix-update = "sudo nix-channel --update && flatpak update --user"; 
    fastfetch-minimal = "fastfetch --config $HOME/.config/fastfetch/config-minimal.jsonc"; 
    histgrep = "history | grep ";
    icat = "kitten icat ";
  };
}
