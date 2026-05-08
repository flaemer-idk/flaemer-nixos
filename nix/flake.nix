{
  description = "my first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # Добавляем unstable ветку
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      # Создаем overlay или переменную с unstable пакетами
      unstable-pkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true; # Если нужны проприетарные драйверы/софт
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        # Передаем unstable пакеты внутрь модулей
        specialArgs = { inherit unstable-pkgs; }; 
        modules = [ ./configuration.nix ];
      };

      homeConfigurations.flaemer = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix ];
      };
    };
}
