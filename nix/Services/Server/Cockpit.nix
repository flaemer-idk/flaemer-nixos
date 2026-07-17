{ pkgs, ... }: {
  services.cockpit = {
    enable = true;
    port = 9090;
    openFirewall = true;
  };

  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    cockpit-files
  ];
}
