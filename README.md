# nixpkgs-pointer

A pointer to fixed versions of `nixpkgs` and other utils.
Doing so allows me to reuse the same `nixpkgs` among my projects.

**Note**: `nix` with flake support is required.


## Usage

Define a flake's input like the following:
```nix
  inputs = {
    nixpkgs-pointer.url = "github:yipengsun/nixpkgs-pointer";
    nixpkgs.follows = "nixpkgs-pointer/nixpkgs";

    flake-parts.follows = "nixpkgs-pointer/flake-parts";
    # or
    flake-utils.follows = "nixpkgs-pointer/flake-utils";
  };
```
