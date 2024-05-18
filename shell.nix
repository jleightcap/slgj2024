with import <nixpkgs> { };
mkShell {
  packages = [ ];
  inputsFrom = [ (callPackage ./. { }) ];
}
