{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation rec {
  name = "fennel-love";
  src = ./.;
  nativeBuildInputs = with pkgs; [ fennel ];
}
