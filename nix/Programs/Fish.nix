{ config, pkgs, ... }: {
  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;
  
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/flaemer/nix#nixos";
    home-switch = "home-manager switch --flake $HOME/nix";
    nix-clean = "sudo nix-collect-garbage -d";
    nsp = "nix-shell -p";
    nixos-update = "sudo nixos-rebuild switch --flake /home/flaemer/nix#nixos --upgrade";
    flatpak-update = "flatpak update -y";
    fastfetch-minimal = "fastfetch --config $HOME/.config/fastfetch/config-minimal.jsonc";
    histgrep = "history | grep ";
    icat = "kitten icat ";
  };
}
