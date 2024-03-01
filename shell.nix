{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = [ ];
  buildInputs = with pkgs; [
    nixpkgs-fmt
    opentofu
  ];
}
