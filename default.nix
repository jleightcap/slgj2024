{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) writeText luaPackages fetchurl fetchFromGitHub;

  lume = luaPackages.buildLuarocksPackage rec {
    pname = "lume";
    version = "2.3.0";
    knownRockspec = (fetchurl {
      url =
        "https://luarocks.org/manifests/Tom9729/${pname}-${version}-0.rockspec";
      sha256 = "sha256-gFHiRSjk48+DHX2Ym4522UyZObNVMzV/AcLNcQKaUuw=";
    }).outPath;
    src = fetchFromGitHub {
      owner = "rxi";
      repo = pname;
      rev = "v${version}";
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
