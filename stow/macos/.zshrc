# Resolve the Stow symlink to find this checkout, wherever it was cloned.
_dotfiles_root=${${(%):-%N}:A:h:h:h}
# Nix and Home Manager session variables, including the user package PATH.
if [[ -r /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
if [[ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]; then
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi
source "$_dotfiles_root/.zshrc"
unset _dotfiles_root
