#packages for me
{ pkgs, ...}:{
environment.systemPackages = with pkgs; [

polkit_gnome 
file-roller

mako
xwayland-satellite

#themes bro
adwaita-qt
#papirus-icon-theme
material-design-icons
material-icons
    morewaita-icon-theme
awatcher 
activitywatch
nautilus

#internetik
chromium

#lite-xl # gone gone thank you

#это ну работа не фейк да да у меня нет ее ну медиа музыка видео там
obs-studio
mpv

#программы ну для вм всяких
rofi

#терминал и терминальное
kitty
awww
cliphist
wl-clipboard
luajit 

#гамес ого какая кнопочка №№№ № № № №№ №№№  
gamemode 
mangohud
gamescope
#steam-run
umu-launcher
 # возможно сделать отдельным конфигом под спорные ибо ну спорные много зависимостей и ненужны
 # типо зачем мне вайн на пк где мне лишь зайти в игру и все надо бы порт протон или чего нить найти
 # или скрипт под протон
 # я чет не нашел а уже 4 декабря почти а именно 3 декабря 20;55 пишу в это время
#wineWowPackages.waylandFull
#winetricks

blueman
pwvucontrol
gnome-disk-utility
pamixer

  (callPackage ./Custom/rbxdclient.nix { })
  (callPackage ./Custom/g4music.nix { })
  (callPackage ./Custom/way-shell.nix { })
];
}   




