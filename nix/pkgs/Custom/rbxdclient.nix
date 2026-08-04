{ lib
, stdenv
, meson
, ninja
, pkg-config
, vala
, gobject-introspection
, wrapGAppsHook4
, glib
, gtk4
, libadwaita
, json-glib
, libsoup_3
, blueprint-compiler
, libxml2
, python3
, umu-launcher
, cage
, makeWrapper
, procps
}:

let
  # python для rfd
  rfd-python = python3.withPackages (ps: with ps; [
    pygobject3
    websocket-client
    requests
    trustme
    urllib3
    pyzstd
    py7zr
    lz4
  ]);
in
stdenv.mkDerivation {
  pname = "rbxdclient";
  version = "1.0.0";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "flaemer";
    repo = "rbxdclient";
    rev = "main";
    hash = "sha256-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=";
  };


  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    gobject-introspection
    wrapGAppsHook4
    blueprint-compiler
    libxml2
    makeWrapper
  ];

  buildInputs = [
    glib
    gtk4
    libadwaita
    json-glib
    libsoup_3
  ];

  postInstall = ''
    wrapProgram $out/bin/rbxdclient \
      --prefix PATH : ${lib.makeBinPath [ rfd-python umu-launcher cage procps ]}

    mkdir -p $out/share/applications
    cat > $out/share/applications/io.codeberg.flaemer.rbxdclient.desktop <<EOF
    [Desktop Entry]
    Type=Application
    Name=Rbxdclient
    Comment=Rbxdclient for bobux on nixos
    Exec=rbxdclient
    Icon=io.codeberg.flaemer.rbxdclient
    Terminal=false
    Categories=Game;Utility;
    EOF

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp $src/data/io.codeberg.flaemer.rbxdclient.svg $out/share/icons/hicolor/scalable/apps/
  '';

  meta = with lib; {
    description = "rbxd client gtk4 libadwaita";
    homepage = "https://codeberg.org/flaemer/rbxdclient";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    mainProgram = "rbxdclient";
  };
}