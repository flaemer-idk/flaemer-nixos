{
  fetchFromGitHub,
  buildGoModule,
  stdenvNoCC,
  nix-update-script,
  nodejs,
  lib,
  fetchPnpmDeps,
  pnpmConfigHook,
  pnpm_10,
}:
let
  pnpm = pnpm_10;
in
buildGoModule (finalAttrs: {
  pname = "memos";
  version = "0.30.0";
  
  src = fetchFromGitHub {
    owner = "usememos";
    repo = "memos";
    rev = "2036c1ffc1b0a1e1fa6a473738c2a5ef520df67f";
    hash = "sha256-MXvEMJN/XyZux/qL/9qZYkbo6fQzYFeCWHxFCtN1M8o="; 
  };

  memos-web = stdenvNoCC.mkDerivation (finalWebAttrs: {
    pname = "memos-web";
    inherit (finalAttrs) version src;
    pnpmDeps = fetchPnpmDeps {
      inherit (finalWebAttrs) pname version src;
      inherit pnpm;
      sourceRoot = "${finalWebAttrs.src.name}/web";
      fetcherVersion = 3;
      hash = "sha256-4oUA0z6VXL0belhK23wZgwCpGmLqDnEez3nMA/uHUTw=";
    };
    pnpmRoot = "web";
    nativeBuildInputs = [
      nodejs
      pnpmConfigHook
      pnpm
    ];
    buildPhase = ''
      runHook preBuild
      pnpm -C web build
      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      cp -r web/dist $out
      runHook postInstall
    '';
  });

  vendorHash = "sha256-nyUBXPC8nt+7s2jFHohF0PWBGky24ZSXWtSI4XVf2kU="; 

  ldflags = [
    "-X github.com/usememos/memos/internal/version.Version=${finalAttrs.version}"
  ];


  doCheck = false;

  preBuild = ''
    rm -rf server/router/frontend/dist
    cp -r ${finalAttrs.memos-web} server/router/frontend/dist
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--subpackage"
      "memos-web"
    ];
  };

  meta = {
    homepage = "https://usememos.com";
    description = "Lightweight, self-hosted memo hub";
    changelog = "https://github.com/usememos/memos/releases/tag/v${finalAttrs.version}";
    maintainers = with lib.maintainers; [
      indexyz
      kuflierl
    ];
    license = lib.licenses.mit;
    mainProgram = "memos";
  };
})