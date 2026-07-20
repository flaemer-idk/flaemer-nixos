{ lib
, stdenv
, meson
, ninja
, pkg-config
, vala
, wrapGAppsHook4
, glib
, gtk4
, libadwaita
, json-glib
, gtk4-layer-shell
, wireplumber
, networkmanager
, libpulseaudio
, wayland
, upower
, wayland-protocols
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "way-shell";
  version = "6.7";
  src = fetchFromGitHub {
    githubBase = "codeberg.org"; # Указываем Codeberg вместо GitHub
    owner = "flaemer";
    repo = "way-shell-maybeforkflaemer";
    rev = "main"; # Имя ветки
    # Хэш для ветки main от 19 июля 2026 (коммит cfb1c7cedc)
    hash = "sha256-LeuWavVb0/fu0D9nE08HcU8ZqmlZ1GTdEkLCdHqOKrU="; 
  };


  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    wrapGAppsHook4
    glib
  ];

  buildInputs = [
    glib
    gtk4
    libadwaita
    json-glib
    gtk4-layer-shell
    wireplumber
    networkmanager
    libpulseaudio
    wayland
    upower
    wayland-protocols
  ];

  mesonFlags = [
    "-Db_lto=true"          
    "-Dstrip=true"         
    "-Db_ndebug=true"       
  ];

  NIX_CFLAGS_COMPILE = [
    "-O3"                 
    "-march=native"         
    "-flto"                   
  ];
    postInstall = ''
    mkdir -p $out/share/glib-2.0/schemas
    cp -r $src/data/*.gschema.xml $out/share/glib-2.0/schemas/
    glib-compile-schemas $out/share/glib-2.0/schemas/
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --prefix XDG_DATA_DIRS : "$out/share"
      --set ADW_DEBUG_COLOR_SCHEME "prefer-dark" # Твоя переменная для темной темы
    )
  '';

  meta = with lib; {
    description = "Lightweight Wayland shell for Niri";
    homepage = "https://codeberg.org/flaemer/way-shell-maybeforkflaemer";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
