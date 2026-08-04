{ lib, stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "mango-go";
  version = "0.1.7";

  # Загружаем готовый релиз с GitHub (вместо исходного кода)
  # ВАЖНО: Вам нужно зайти на https://github.com/vrsandeep/mango-go/releases
  # и проверить точное название файла архива для Linux (x86_64/amd64).
  # Ниже указан примерный URL, замените его на правильный, если он отличается:
  src = fetchurl {
    url = "https://github.com/vrsandeep/mango-go/releases/download/v0.1.7/mango-go-linux-amd64.tar.gz"; 
    hash = "sha256-We1ohmkMbje3KztZiFSaSJKUoM6PWnTozMJYMUkWe5Y="; # Заглушка, обновите после ошибки
  };

  # Так как мы качаем тарбол, Nix сам его распакует
  sourceRoot = ".";

  dontConfigure = true;
  dontBuild = true;

  # Эта магия Nix автоматически починит бинарник от Ubuntu для работы в NixOS
  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir -p $out/bin
    cp build/mango-go* $out/bin/mango-go
    chmod +x $out/bin/mango-go
  '';

  meta = with lib; {
    description = "Self-hosted manga server and web reader written in Go";
    homepage = "https://github.com/vrsandeep/mango-go";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}