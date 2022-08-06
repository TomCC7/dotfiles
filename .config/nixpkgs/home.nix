{ config, pkgs, lib, ... }:
{
  home.username = "cc";
  home.homeDirectory = "/home/cc";

  imports = [ ./packages/packages.nix ./configs/configs.nix];
}
