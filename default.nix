{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) writeText luaPackages fetchurl fetchFromGitHub;

  luafun = luaPackages.buildLuarocksPackage rec {
    pname = "luafun";
    version = "0.1.3";
    knownRockspec = (fetchurl {
      url = "https://raw.github.com/luafun/luafun/master/fun-scm-1.rockspec";
      sha256 = "sha256-35RcuCYBf5nSO65qBYLYNWmRCaCbFqQdXrk3wBy/lQU=";
    }).outPath;
    src = fetchFromGitHub {
      owner = "luafun";
      repo = pname;
      rev = version;
      hash = "sha256-aOriC7VD29XzchvLOfmySNDR1MtO1xrqHYABRMaDoJo=";
    };
  };
in pkgs.stdenv.mkDerivation rec {
  name = "fennel-love";
  src = ./.;
  nativeBuildInputs = with pkgs; [
    fennel
    zip
    (lua5_2.withPackages (ps: with ps; [ luafun ]))
  ];

  installPhase = ''
    mkdir $out
    cp *.lua $out/
  '';
}
