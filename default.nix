{ pkgs ? import <nixpkgs> {} }:

let generator = ./generator;

in pkgs.stdenv.mkDerivation {
  name = "blog.greghale.io";
  src  = ./site;
  phases = "unpackPhase buildPhase";
  buildInputs = [ generator ];
  buildPhase = ''
    LANG=en_US.UTF-8 generator build
    mkdir $out
    cp -r _site/* $out
  '';
  }
