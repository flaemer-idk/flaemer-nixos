{ pkgs, ... }: {
  services.kavita = {
    enable = true;

    settings = {
      IpAddresses = "0.0.0.0";
      Port = 5050;
    };
  };
}
