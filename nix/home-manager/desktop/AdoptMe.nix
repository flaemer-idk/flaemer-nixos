{ ... }: {
xdg.desktopEntries = {
  "AdoptMe" = {
    name = "Adopt Me";
    genericName = "Roblox Game";
    comment = "игра где надо быть кем то таким то";
    icon = ./icons/AdoptMe.png; 
    exec = "flatpak run org.vinegarhq.Sober \"roblox://placeId=920587237\"";
    terminal = false;
    categories = [ "Game" ];
  };
};
}
