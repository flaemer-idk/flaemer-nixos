{ ... }: {
xdg.desktopEntries = {
  "Gearworks" = {
    name = "Gearworks";
    genericName = "Roblox Game";
    comment = "игра где надо быть кем то таким то";
    icon = ./icons/Gearworks.png; 
    exec = "flatpak run org.vinegarhq.Sober \"roblox://placeId=13158116555\"";
    terminal = false;
    categories = [ "Game" ];
  };
};
}
