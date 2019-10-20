{ nixpkgs ? import <nixpkgs> {} }:


let
  shellPkgs =
    { config-phases = ["generic-lens" "lens" "postgresql-simple" "katip"]; };


   shellFor = name: pWantedNames:
     let
       haskellDeps =
         nixpkgs.haskellPackages.ghcWithPackages
         (ps: builtins.map
              (p: nixpkgs.haskell.lib.dontCheck ps."${p}")
              pWantedNames
         );
     in
       nixpkgs.stdenv.mkDerivation {
         name = name;
         buildInputs = [haskellDeps];
       };

in

builtins.mapAttrs shellFor shellPkgs
