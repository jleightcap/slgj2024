with import <nixpkgs> { };
mkShell {
  packages = [ fnlfmt (lua5_2.withPackages (ps: with ps; [ readline ])) ];
  inputsFrom = [ (callPackage ./. { }) ];
}
