(use-modules (gnu)
             (gnu system nss)
             (nongnu packages linux)
             (nongnu packages nvidia)
             (nongnu system linux-initrd)
             (srfi srfi-1))
(use-service-modules desktop
                     sound
                     networking
                     xorg
                     docker
                     virtualization
                     pm
                     cups)
(use-package-modules bootloaders
                     certs
                     vim
                     bash
                     rust-apps
                     xorg
                     linux
                     version-control
                     gnuzilla
                     cryptsetup
                     compton
                     ;; gnome
                     curl
                     admin
                     ssh
                     web-browsers
                     disk
                     file-systems
                     suckless
                     audio
                     pulseaudio
                     fonts
                     xdisorg
                     terminals
                     shells
                     wm)
;; nvidia udev
(simple-service 'custom-udev-rules udev-service-type (list nvidia-driver))

;; Allow members of the "video" group to change the screen brightness.
(define %backlight-udev-rule
  (udev-rule
   "90-backlight.rules"
   (string-append "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                  "RUN+=\"/run/current-system/profile/bin/chgrp video /sys/class/backlight/intel_backlight/brightness\""
                  "\n"
                  "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                  "RUN+=\"/run/current-system/profile/bin/chmod g+w /sys/class/backlight/intel_backlight/brightness\"")))

(operating-system
 ;; nonguix settings
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware sof-firmware alsa-ucm-conf))
 ;; system
 (host-name "cccomputer")
 (timezone "America/Detroit")
 (locale "en_US.utf8")
 (keyboard-layout (keyboard-layout "us" #:options '("ctrl:nocaps")))
 ;; uefi
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))))

 (file-systems (append
                (list 
                 (file-system
                  (device (uuid "0e0776fb-2a03-4b86-81bb-1c33c311bab3"))
                  (mount-point "/")
                  (type "btrfs")
                  (options "subvol=root"))
                 (file-system
                  (device (uuid "8CBE-7EF0" 'fat))
                  (mount-point "/boot/efi")
                  (type "vfat")))
                %base-file-systems))
 ;; user
 (users (cons (user-account
               (name "cc")
               (group "users")
               (shell (file-append zsh "/bin/zsh"))
               ;; (shell (file-append bash "/bin/bash"))
               (supplementary-groups '("wheel" ;; sudo
                                       "netdev" ;; control network devices
                                       "tty"
                                       "input"
                                       "docker" ;; docker
                                       ;; virtual machines
                                       "kvm"
                                       "libvirt"
                                       "realtime" ;; Enable realtime scheduling
                                       "lp" ;; control bluetooth devices
                                       "audio" ;; control audio devices
                                       "video"))) ;; control video devices
              %base-user-accounts))
 ;; Add the 'realtime' group
 (groups (cons (user-group (system? #t) (name "realtime"))
               %base-groups))
 ;; packages
 (packages (append (list
                    ;; editor
                    neovim
                    ;; tools
                    git curl htop openssh
                    ;; disks
                    exfat-utils fuse-exfat ntfs-3g cryptsetup ;;ntfs-3g-static ntfsfix-static
                    ;; hardwares
                    bluez bluez-alsa pulseaudio tlp xf86-input-libinput alsa-utils pamixer
                    nvidia-driver nvidia-libs
                    ;; window managers
                    i3-gaps i3status rofi polybar picom
                    xrandr autorandr
                    ;; fonts
                    font-adobe-source-code-pro font-adobe-source-han-sans
                    font-google-material-design-icons
                    ;; terminal & shell
                    alacritty xterm zsh
                    ;; https
                    nss-certs qutebrowser)
                   %base-packages))

 (services (cons* (service thermald-service-type)
            (pam-limits-service ;; This enables JACK to enter realtime mode
             (list
              (pam-limits-entry "@realtime" 'both 'rtprio 99)
              (pam-limits-entry "@realtime" 'both 'memlock 'unlimited)))
            (extra-special-file "/usr/bin/env"
                                (file-append coreutils "/bin/env"))
            (extra-special-file "/usr/bin/zsh"
                                (file-append zsh "/bin/zsh"))

            (bluetooth-service #:auto-enable? #t)
            (service docker-service-type)
            (service libvirt-service-type
                     (libvirt-configuration
                      (unix-sock-group "libvirt")
                      (tls-port "16555")))
            (service tlp-service-type
                     (tlp-configuration
                      (cpu-boost-on-ac? #t)
                      (wifi-pwr-on-bat? #t)))
            (cons* (udev-rules-service 'backlight "backlight-udev-rule")
                   (set-xorg-configuration
                    (xorg-configuration
                     (keyboard-layout keyboard-layout)))
                   %desktop-services)))

 ;; nvidia settings
 ;; allow resolution of '.local' host names with mDNS
 (name-service-switch %mdns-host-lookup-nss))
