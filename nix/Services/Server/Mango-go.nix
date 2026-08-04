{ pkgs ? import <nixpkgs> {} }:

pkgs.buildGoModule rec {
  pname = "mango-go";
  version = "0.1.7"; # Последний стабильный релиз

  src = pkgs.fetchFromGitHub {
    owner = "vrsandeep";
    repo = "mango-go";
    rev = "v${version}";
    # ИИ поставил хэш-заглушку "aaa...", как вы просили.
    # NixOS при первой попытке сборки выдаст ошибку и сам напечатает правильный хэш.
    hash = "sha256-fdrdbVhxpJkacoAVLUO6kPAS7PEGi2rT4wlQV9PG9MA=";
  };

  # Заглушка для хэша внешних зависимостей (go.mod)
  vendorHash = "sha256-uRHpvfy6ruvof9ucJ+GR8Z65mnALitHOgTUHPp+/1IU=";

  # Включаем компиляцию C-кода (нужно для SQLite базы данных)
  env = {
    CGO_ENABLED = "1";
  };

  # Библиотеки, необходимые для компиляции SQLite на Go
  nativeBuildInputs = [ pkgs.pkg-config pkgs.gcc ];
  buildInputs = [ pkgs.sqlite ];

  meta = with pkgs.lib; {
    description = "Mango is a self-hosted manga server and web reader written in Go";
    homepage = "https://github.com/vrsandeep/mango-go";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
