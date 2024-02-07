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
          oldVerit = import (builtins.fetchGit {
            # Descriptive name to make the store path easier to identify
            name = "veriT-smtcoq";
            url = "https://github.com/NixOS/nixpkgs/";
            ref = "refs/heads/nixos-22.11";
            rev = "3479555209833f42c16f9da373b6f64af1b06c4a";
          }) { inherit system; };
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              # Install Coq 8.13; smtcoq appears broken on later versions.
              #coqPackages_8_13.smtcoq
              coq_8_13
              cvc4
              cvc5
              oldVerit.veriT
              zchaff
            ];
            nativeBuildInputs = with ocamlPackages; [
              ocaml
              findlib
              dune_1
              num
              menhir
              zarith
              ocaml-lsp
            ];
          };
        }
      );
}
