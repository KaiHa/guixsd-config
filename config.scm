;; This is the guix operating system configuration

(use-modules (gnu)
             (gnu packages base)
             (gnu packages bash)
             (gnu packages curl)
             (gnu packages emacs)
             (gnu packages gnupg)
             (gnu packages image-viewers)
             (gnu packages linux)
             (gnu packages mail)
             (gnu packages mc)
             (gnu packages stalonetray)
             (gnu packages screen)
             (gnu packages shells)
             (gnu packages ssh)
             (gnu packages tmux)
             (gnu packages version-control)
             (gnu packages xdisorg)
             (gnu packages xorg)
             (gnu system nss)
             )
(use-service-modules desktop ssh)
(use-package-modules wm ratpoison certs suckless)

(operating-system
  (host-name "antelope")
  (timezone "Europe/Berlin")
  (locale "en_US.utf8")

  (bootloader (grub-configuration (device "/dev/vda")))

  (file-systems (cons (file-system
                        (device "guix")
                        (title 'label)
                        (mount-point "/")
                        (type "ext4"))
                      %base-file-systems))

  (users (cons (user-account
                (name "kai")
                (comment "Kai Harries")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"))
                (home-directory "/home/kai")
                (shell #~(string-append #$zsh "/bin/zsh")))
               %base-user-accounts))

  (packages (cons* bash-completion
                   byobu
                   curl
                   dmenu
                   emacs
                   emacs-evil
                   emacs-helm
                   feh
                   ghc-xmonad-contrib
                   git
                   gnupg
                   grep
                   haskell-mode
                   i3-wm
                   i3status
                   magit
                   mc
                   neomutt
                   nss-certs
                   openssh
                   psmisc
                   rxvt-unicode
                   tmux
                   ratpoison
                   stalonetray
                   xcompmgr
                   xinit
                   xmonad
                   xrandr
                   xset
                   xsetroot
                   zsh
                   %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with Wicd, and more.
  (services (cons* (service openssh-service-type
                      (openssh-configuration
                        (permit-root-login #f)))
                   %desktop-services))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
