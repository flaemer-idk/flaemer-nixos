{ config, pkgs, ... }: {
    home = {
            username = "flaemer";
            homeDirectory = "/home/flaemer";
            stateVersion = "26.05";
            
        }; 
          
	imports = [
		./home-manager/niri/config.nix
		./home-manager/other/kitty.nix
		./home-manager/other/fastfetch.nix
		./home-manager/other/themes.nix
    	./home-manager/other/mangohud.nix
		./home-manager/rofi/rofi.nix
		./home-manager/eww/eww.nix

		./home-manager/desktop/AdoptMe.nix
		./home-manager/desktop/Gearworks.nix	
	];
programs.fish = {
enable = true;
shellAliases = 
let
	flakePath = "/home/flaemer/nix/";
in {
rebuild = "sudo nixos-rebuild switch --flake /home/flaemer/nix#nixos"; #ребилд системы
home-switch = "home-manager switch --flake ${flakePath}"; #ребилд хоума ну замена чистка короче хоум менеджер
nix-clean = "sudo nix-collect-garbage -d"; # чистка от старого
nix-shell = "nix-shell -p"; # никс шелл это
nixos-update = "nixos-rebuild switch --upgrade"; # обнова
nix-update = "sudo nix-channel --update && flatpak update --user"; # абнова никпгс и флатпак апсов
fastfetch-minimal = "fastfetch --config /home/flaemer/.config/fastfetch/config-minimal.jsonc"; # минимал фаст фетч
histgrep = "history | grep ";
icat = "kitten icat ";
		};
	};         
}


