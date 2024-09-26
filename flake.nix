{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";  # for backward compat

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs = { self, flake-parts, ... } @ inputs:
    let
      name = toString self.lastModified;
    in
    flake-parts.lib.mkFlake { inherit inputs; } ({ ... }: {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { pkgs, ... }:
        let
          nixpkgs-pointer-version = pkgs.writeScriptBin "nixpkgs-pointer-version" ''
            #!${pkgs.stdenv.shell}
            echo "${name}"
          '';
        in
        {
          packages.nixpkgs-pointer-version = nixpkgs-pointer-version;

          devShells.default = pkgs.mkShell.override { stdenv = pkgs.stdenvNoCC; } {
            buildInputs = [ nixpkgs-pointer-version ];
          };
        };
    });
}
