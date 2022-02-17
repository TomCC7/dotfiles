{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  programs = {
    vscode = {
      enable = true;
    };
  };
}
