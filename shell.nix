with import <nixpkgs> { };
mkShell {
  packages = [ fnlfmt ];
  inputsFrom = [ (callPackage ./. { }) ];
}
