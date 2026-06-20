{
  lib,
  stdenv,
  fetchFromGitHub,
  desktop-file-utils,
  gitUpdater,
  gobject-introspection,
  gst_all_1,
  gtk4,
  libadwaita,
  meson,
  ninja,
  pkg-config,
  vala,
  wrapGAppsHook4,
  libsoup_3,
  json-glib, 
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "gapless";
  version = "67";
  
src = fetchFromGitHub {
    githubBase = "codeberg.org";
    owner = "flaemer";
    repo = "g4music-flaemer";
    rev = "main";
    hash = "sha256-Rqt8pQhodu3xG1Nk/6XuGDw4K3GGSE+eAjgul8VzhSA=";
  };


  
  nativeBuildInputs = [
    desktop-file-utils
    gobject-introspection
    meson
    ninja
    pkg-config
    vala
    wrapGAppsHook4
    libsoup_3
    json-glib
  ];

  buildInputs = [
    gtk4
    libadwaita
  ]
  ++ (with gst_all_1; [
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gstreamer
    
  ]);

  passthru.updateScript = gitUpdater {
    rev-prefix = "v";
  };
})
