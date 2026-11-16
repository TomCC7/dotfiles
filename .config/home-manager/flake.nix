{
  description = "Minimal macOS CLI environment; existing Linux entry stays unchanged";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, ... }:
    let
      mkMac = system: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [ ./mac-minimal.nix ];
      };
    in {
      homeConfigurations = {
        mac-arm = mkMac "aarch64-darwin";
        mac-intel = mkMac "x86_64-darwin";
      };
    };
}
