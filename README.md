# nixpkgs-pointer
A pointer to a version of nixpkgs so all my projects can reuse the same nixpkgs
version. This may also contain overlays that are useful for all my projects.

**Note**: `nix` with flake support is required.


## Usage

Define a flake's input like the following:
```nix
  inputs = {
    nixpkgs-pointer.url = "github:yipengsun/nixpkgs-pointer";
    nixpkgs.follows = "nixpkgs-pointer/nixpkgs";
    flake-utils.follows = "nixpkgs-pointer/flake-utils";
  };
```
