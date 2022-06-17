{
  description = "A pointer to a version of nixpkgs.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      name = toString self.lastModified;
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {
        packages = flake-utils.lib.flattenTree {
          nixpkgs-pointer-version = pkgs.writeScriptBin "nixpkgs-pointer-version" ''
            #!${pkgs.stdenv.shell}
            echo "${self.name}"
          '';
        };
        defaultPackage = packages.nixpkgs-pointer-version;
      }
    );
}
