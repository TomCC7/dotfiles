{ pkgs, ... }:
let
  envOr = name: fallback:
    let value = builtins.getEnv name;
    in if value == "" then fallback else value;
  username = envOr "DOTFILES_MAC_USER" (builtins.getEnv "USER");
  homeDirectory = envOr "DOTFILES_MAC_HOME" (builtins.getEnv "HOME");
in {
  # --impure supplies the real macOS username/home; do not run with sudo.
  assertions = [ {
    assertion = username != "" && username != "root"
      && builtins.match "/Users/.+" homeDirectory != null;
    message = "Run as your macOS user with --impure and HOME=/Users/<user>.";
  } ];
  home = {
    inherit username homeDirectory;
    stateVersion = "25.05";
    packages = with pkgs; [
      git git-lfs stow ripgrep fd fzf jq tmux neovim
      direnv nix-direnv eza bottom htop lua unzip
    ];
  };
  programs.home-manager.enable = true;
  # Stow, not Home Manager, owns .zshrc, .p10k.zsh and Ghostty config.
  # Keep fonts/GUI apps in Brew; leave the macOS login shell untouched.
}
