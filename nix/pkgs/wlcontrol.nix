{ pkgs ? import <nixpkgs> { } }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wlcontrol";
  version = "unstable-2024-05-14"; 

  src = pkgs.fetchFromGitHub {
    owner = "neoden";
    repo = "wlcontrol";
    rev = "master"; 
    hash = "sha256-qFbvRDff5dUR7xg2KmwNeuCYelFtfWz7CAaK/mu81Vg="; 
  };

  cargoHash = "sha256-O+vAFIXu1t9DRdT6uhTv5IQjt+SGbnbHzMmE07RCWs0=";

  nativeBuildInputs = with pkgs; [
    pkg-config
    blueprint-compiler
    wrapGAppsHook4 
  ];

  buildInputs = with pkgs; [
    gtk4
    libadwaita
    glib
    dbus
    gdk-pixbuf
  ];

  meta = with pkgs.lib; {
    description = "WiFi and Bluetooth control app for Linux, built with GTK4/libadwaita";
    homepage = "https://github.com/neoden/wlcontrol";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "wlcontrol";
  };
}
