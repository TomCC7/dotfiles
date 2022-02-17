(use-modules
 (gnu home)
 (gnu packages)
 (gnu services)
 (guix gexp)
 (gnu home services shells)
 (gnu home services utils))

(home-environment
 (packages
  (map (compose list specification->package+output)
       (list
        ;;  tools
        "git" "tig" "curl" "exa" "tmux" "stow" "flameshot"
        "ncurses" "ranger" "ncdu" "flatpak"
        ;; xorgs
        "xinput" "xclip" ;; "xrdb"
        ;; hardwares control
        "blueman" "pavucontrol" "virt-manager"
        ;; {{ programming
        ;; python
        "python" "python-wrapper" "python-pip"
        "python-evdev" "python-pygame" "poetry"
        ;; c++
        "gcc-toolchain" "clang-toolchain" "clang"
        "llvm" "cling"
        ;; latex
        "texlive"
        ;; }}
        ;; pdf
        "okular" "zathura-pdf-mupdf" "zathura"
        ;; apps
        "telegram-desktop" "nextcloud-client"
        ;; emacs
        "emacs-pgtk-native-comp" "emacs-eldev" "emacs-epl" "emacs-pdf-tools"
        "emacs-vterm" "grip" "emacs-emacsql-sqlite3" "emacs-emacsql"
        "emacs-guix"
        ;; fonts
        "font-adobe-source-han-sans:cn" "font-adobe-source-code-pro"
        "font-google-material-design-icons" "arc-icon-theme"
        ;; input
        "fcitx5" "fcitx5-configtool" "fcitx5-qt"
        "fcitx5-gtk" "fcitx5-chinese-addons"
        )))
 (services
  (list
   (service home-zsh-service-type
            (home-zsh-configuration
             (environment-variables
              '(("VISUAL" . "nvim")
                ("EDITOR" . "nvim")
                ;; PATH
                ("PATH" . "$HOME/.local/bin:$PATH")
                ("PATH" . "$HOME/.nix-profile/bin:$PATH")
                ;; display
                ("GDK_SCALE" . "2")
                ("QT_AUTO_SCREEN_SCALE_FACTOR" . "1")
                ("QT_SCALE_FACTOR" . "2")
                ;; fcitx5
                ("GTK_IM_MODULE" . "fcitx")
                ("QT_IM_MODULE" . "fcitx")
                ("XMODIFIERS" . "@im=fcitx")))
             ;; (zshrc '("source \"$HOME/.config/zsh/.zshrc\""))
             ;; (zshrc '("/home/cc/.config/zsh/.zshrc"))
             (xdg-flavor? #f)))

   ;; (simple-service 'my-services
   ;;                 home-shepherd-service-type
   ;;                 (list my-syncthing-service))
   )))
