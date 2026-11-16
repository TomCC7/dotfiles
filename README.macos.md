# Minimal macOS environment

Ghostty + the existing zsh configuration + Stow. Home Manager owns CLI
packages; Brew owns Ghostty and the Meslo Nerd Font. No nix-darwin, no login-shell
replacement, and no change to the existing Linux Home Manager entry.

## 1. Prerequisites

Run as your normal macOS user, not with `sudo`. Apple Silicon and Intel are
supported as separate configurations. Install Apple's command line tools:

```sh
xcode-select --install
```

Wait for the installer to finish. If already installed, skip this step.
Install Homebrew if `brew --version` fails, using the official instructions:
<https://brew.sh/>. Follow its printed `brew shellenv` instructions before continuing.

Install Nix if `nix --version` fails, using the official multi-user installer:

```sh
curl -L https://nixos.org/nix/install -o "$HOME/nix-install.sh"
sh "$HOME/nix-install.sh" --daemon
```

The installer requires administrator approval and modifies system Nix setup.
Open a new terminal after it finishes, then check `nix --version`.
Do not install over an existing working Nix installation.

## 2. Clone and install GUI apps

For the initial feature branch (use main after this branch is merged):

```sh
git clone --branch feat/macos-minimal https://github.com/TomCC7/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"
brew bundle --file=Brewfile.macos
```

If you already have a checkout, fetch and switch to `feat/macos-minimal` there
instead. Preserve uncommitted changes; do not overwrite an existing checkout.
Do not run Stow over this whole repository: it also contains Linux-specific
configs, shell history, caches and other unrelated files.

## 3. Activate Home Manager

```sh
cd "$HOME/dotfiles"
case "$(uname -m)" in
  arm64) profile=mac-arm ;;
  x86_64) profile=mac-intel ;;
  *) printf 'Unsupported architecture\n'; return 1 ;;
esac
nix --extra-experimental-features 'nix-command flakes' run \
  github:nix-community/home-manager/release-26.05 -- \
  switch --impure --flake "./.config/home-manager#$profile"
```

Run in a native terminal on Apple Silicon (not Rosetta). `--impure` reads your
current USER and HOME instead of hardcoding `/Users/cc`. Both the Home Manager
and nixpkgs inputs for the actual environment are pinned in `flake.lock`.
`home.stateVersion` is a compatibility setting, not the package version: do not
bump it on routine updates.

Packages: Git, Git LFS, Stow, ripgrep, fd, fzf, jq, tmux, Neovim, direnv,
nix-direnv, eza, bottom, htop, Lua and unzip. This configuration does not generate
your Git config, SSH config, .zshrc, or global language project environments.

Make the newly installed CLI tools available in the current shell:

```sh
export PATH="$HOME/.nix-profile/bin:$PATH"
```

## 4. Link only the Mac overlay

First preview; Stow refuses conflicting files rather than replacing them:

```sh
cd "$HOME/dotfiles"
bash scripts/mac-stow.sh --simulate --verbose
```

If `.zshrc`, `.p10k.zsh` or `.config/ghostty/config` already exists, move only the
conflicting file(s) to your own backup location and repeat the preview. Do not
use `--adopt`, and do not move all of `~/.config`. Then apply:

```sh
bash scripts/mac-stow.sh --verbose
exec /bin/zsh -l
```

The overlay links only `.zshrc`, `.p10k.zsh`, and Ghostty's config. Its `.zshrc`
loads Nix session variables and then sources the original repo `.zshrc`, so the
existing zinit plugins and prompt remain in use. First shell launch downloads
zinit/plugins from GitHub; it needs a working network and is not fully locked by
Nix. Linux-only aliases/functions remain present but are not intended for use on
macOS. Existing Linux Home Manager configuration is not migrated or activated.

`nix-direnv` is installed, but this minimal setup does not automatically enable
its direnv integration or approve project `.envrc` files. Enable those per
project if needed.

## 5. Verify on the Mac

```sh
command -v git stow rg fd fzf jq tmux nvim direnv
home-manager generations
ls -l ~/.zshrc ~/.p10k.zsh ~/.config/ghostty/config
open -a Ghostty
```

In Ghostty, confirm the prompt/icons render and left Option works as Alt.
If the font is not found, choose the installed MesloLGS Nerd Font with Ghostty's
font picker or inspect `ghostty +list-fonts`; adjust the overlay config if needed.

## Updates and rollback

Keep your checkout at the same path while its Stow links are active. Repeat
step 3 to apply config changes; use `nix flake update` inside
`.config/home-manager` only when you deliberately want new dependency versions,
and commit the resulting lockfile. Update Brew apps separately with Brew.

Remove only the Stow links created by this overlay:

```sh
bash scripts/mac-stow.sh --delete --verbose
```

Restore your backed-up files afterward. For Home Manager, inspect
`home-manager generations` and run a selected older generation's `activate`
script to return to that configuration. First-generation removal is a separate
operation; unlinking Stow alone does not uninstall Nix packages or Brew apps.

## Verification scope

Both Darwin activation derivations are evaluated from the lockfile on Linux.
Stow creation/removal, conflict handling, symlink resolution and zsh syntax are
tested in an isolated HOME. A fresh interactive zsh startup also completed on
Linux with the real zinit/plugin downloads and no missing-file/command errors.
Actual Darwin builds, Nix installation on macOS,
GUI rendering and macOS plugin behavior still require the Mac-side checks above.
