{
  description = "Flake for SMTCoq work";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
          ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_10;
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              # Install Coq 8.13; smtcoq appears broken on later versions.
              #coqPackages_8_13.smtcoq
              coq_8_13
              cvc4
              veriT
              zchaff
            ];
            nativeBuildInputs = with ocamlPackages; [
              ocaml
              findlib
              dune_2
              num
            ];
          };
        }
      );
}
