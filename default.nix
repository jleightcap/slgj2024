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

  tick = luaPackages.buildLuarocksPackage rec {
    pname = "tick";
    version = "0.1.1";
    knownRockspec = (writeText "${pname}-${version}-0.rockspec" ''
      package = "${pname}"
      version = "${version}-0"
      source = {
         url = "https://github.com/rxi/tick"
      }
      description = {
         summary = "Lua module for delaying function calls ",
         detailed = "Lua module for delaying function calls ",
         homepage = "https://github.com/rxi/tick",
         license = "MIT"
      }
      dependencies = {
         "lua >= 5.1, < 5.4"
      }
      build = {
         type = "builtin",
         modules = {
            tick = "tick.lua",
         }
      }
    '').outPath;
    src = fetchFromGitHub {
      owner = "rxi";
      repo = pname;
      rev = "4708b24b44554a1bc410c618737bfcac66bcc943";
      hash = "sha256-6f3VClqTq4w5wFejn1K9Zsh0CTctarC9nJ0hIU8Y4WM=";
    };
  };
in pkgs.stdenv.mkDerivation rec {
  name = "fennel-love";
  src = ./.;
  nativeBuildInputs = with pkgs; [
    fennel
    (lua5_2.withPackages (ps: with ps; [ lume tick ]))
  ];
}
