{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, hakyll, stdenv }:
      mkDerivation {
        pname = "blog-greghale-io";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [ base hakyll nixpkgs.cabal-install ];
        license = "unknown";
        hydraPlatforms = stdenv.lib.platforms.none;
      };

  haskellPackages = (if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler}).override { overrides = self: super: {
    # hakyll = pkgs.haskell.lib.dontCheck (pkgs.haskell.lib.doJailbreak (self.callHackage "hakyll" "4.13.4.0" {}));
    # pandoc = pkgs.haskell.lib.dontCheck (self.callHackage "pandoc" "2.9.2.1" {});
    # pandoc-types = pkgs.haskell.lib.dontCheck (self.callHackage "pandoc-types" "1.20" {});
  };
  };

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
