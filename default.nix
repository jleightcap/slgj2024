{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) luaPackages fetchurl;
  lume = luaPackages.buildLuarocksPackage rec {
    pname = "lume";
    version = "v2.3.0";
    knownRockspec = (fetchurl {
      url = "https://luarocks.org/manifests/Tom9729/lume-2.3.0-0.rockspec";
      sha256 = "sha256-gFHiRSjk48+DHX2Ym4522UyZObNVMzV/AcLNcQKaUuw=";
    }).outPath;
    src = pkgs.fetchFromGitHub {
      owner = "rxi";
      repo = "lume";
      rev = version;
      hash = "sha256-Q9+sLbJ8PaJ2xx/7UCkhnv5yCHueJ4hDdCPaVEQ45KA=";
    };
  };
in pkgs.stdenv.mkDerivation rec {
  name = "fennel-love";
  src = ./.;
  nativeBuildInputs = with pkgs; [
    fennel
    (lua5_2.withPackages (ps: with ps; [ lume ]))
  ];
}
