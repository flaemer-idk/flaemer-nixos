{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, wayland-scanner
, wrapGAppsHook4
, glib # <- Добавили сюда для утилиты glib-compile-schemas
, gtk4
, libadwaita
, gtk4-layer-shell
, upower
, wireplumber
, json-glib
, networkmanager
, libpulseaudio
, wayland-protocols
, wayland
, pipewire
, gsettings-desktop-schemas
, dconf
}:

stdenv.mkDerivation rec {
  pname = "way-shell";
  version = "0.0.10";

  src = fetchFromGitHub {
    owner = "ldelossa";
    repo = "way-shell";
    rev = "main"; # <- Переключаемся на свежую ветку с поддержкой Niri
    hash = "sha256-qAGhlkquiByrVq5Z0pXNzY0XoEOB9eCyaGm1d9Nv3q0="; # <- Временная заглушка
  };

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
    wrapGAppsHook4
    glib # <- Добавили сюда, чтобы Nix мог скомпилировать схемы при сборке
  ];

  buildInputs = [
    glib
    gtk4
    libadwaita
    gtk4-layer-shell
    upower
    wireplumber
    json-glib
    networkmanager
    libpulseaudio
    wayland-protocols
    wayland
    pipewire
    gsettings-desktop-schemas
    dconf
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  postPatch = ''
    if grep -q "gtk4-layer-shell-0" Makefile && ! grep -q "libpipewire" Makefile; then
      substituteInPlace Makefile \
        --replace-fail "gtk4-layer-shell-0" "gtk4-layer-shell-0 libpipewire-0.3"
    fi
  '';

  # НОВЫЙ БЛОК: Гарантируем правильную установку и компиляцию GSettings-схем
  postInstall = ''
    # Создаем папку для схем в нашем изолированном пути $out
    mkdir -p $out/share/glib-2.0/schemas
    
    # Если Makefile не скопировал схему в правильное место, копируем ее вручную из исходников
    if [ ! -f $out/share/glib-2.0/schemas/org.ldelossa.way-shell.gschema.xml ]; then
      find . -name "org.ldelossa.way-shell.gschema.xml" -exec cp {} $out/share/glib-2.0/schemas/ \;
    fi
    
    # Компилируем схему в бинарный формат gschemas.compiled
    glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta = with lib; {
    description = "A Gnome-like shell for wayland compositors";
    homepage = "https://github.com/ldelossa/way-shell";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    mainProgram = "way-shell";
  };
}