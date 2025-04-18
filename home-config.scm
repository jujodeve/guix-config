;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(load "./modules/fonts.scm")

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
	     (guix store)
	     (gnu packages linux)
             (gnu home services shells)
	     (gnu home services sound)
	     (gnu home services desktop)
	     (gnu packages fonts)
	     (gnu packages version-control)
	     (gnu packages vim)
             (gnu home services shells)
             (gnu home services dotfiles)
	     (gnu packages compression)
	     (gnu packages admin)
	     (gnu packages virtualization)
	     (gnu packages spice)
	     (gnu packages rust-apps)
	     (gnu packages emacs)
	     (gnu packages emacs-xyz)
	     (gnu packages shellutils)
	     (gnu packages pulseaudio)
	     (gnu packages fontutils)
	     (gnu packages xfce)
	     (gnu packages networking)
	     (nongnu packages mozilla)
	     (nongnu packages game-client)
	     (jtx/fonts))

(define %jtx/emacs-packages
  (list
   emacs
   emacs-vterm
   emacs-vertico
   emacs-marginalia
   emacs-consult
   emacs-orderless
   emacs-multiple-cursors
   emacs-dashboard
   emacs-spacemacs-theme
   emacs-spaceline
   emacs-nerd-icons
   emacs-all-the-icons-dired
   emacs-all-the-icons
   emacs-rainbow-delimiters
   emacs-which-key
   emacs-beacon
   emacs-smart-hungry-delete
   ;;emacs-hungry-delete
   emacs-sudo-edit
   emacs-undo-tree
   emacs-org-auto-tangle
   emacs-org-bullets
   emacs-toc-org
   emacs-magit
   emacs-eshell-prompt-extras
   ;;emacs-eshell-info-banner
   emacs-eshell-z
   emacs-company
   emacs-sly
   emacs-treemacs
   emacs-lua-mode
   emacs-org-present
   emacs-visual-fill-column
   emacs-dmenu
   emacs-bluetooth
   emacs-pinentry
   emacs-cfrs))

(define %jtx/bashrc "
source /gnu/store/krf43gjpnrw05vrkaqa6c3h56rqwzjnh-liquidprompt-2.1.2/share/liquidprompt/liquidprompt
#source /gnu/store/dzn7mlkkxwjpl6jj2f6lrk4bx2fji0nc-liquidprompt-2.1.2/share/liquidprompt/themes/powerline/powerline.theme
neofetch
")

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
 (packages ;;(specifications->packages
  (append (list
	   virt-manager
	   neofetch
	   font-jetbrains-mono
	   git
	   neovim
	   firefox
	   p7zip
	   usbredir
	   exa
	   bat
	   liquidprompt
	   font-tamzen
	   pavucontrol
	   wireplumber
	   pipewire
	   fontconfig
	   font-tamzen
	   font-hack
	   font-powerline
	   blueman
	   steam)
	  %jtx/emacs-packages))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list (service home-bash-service-type
                  (home-bash-configuration
		   (environment-variables '(("EDITOR" . "emacs -nw")
					    ("VISUAL" . "emacs")))
                   (aliases '(("cdc" . "cd ~/guix-config")
                              ("exa" . "eza --icons")
                              ("grep" . "grep --color=auto")
                              ("ip" . "ip -color=auto")
                              ("l" . "la")
                              ("la" . "eza -lha")
                              ("ll" . "eza -l")
                              ("ls" . "eza")
                              ("lt" . "eza --tree")
                              ("vi" . "nvim")
                              ("vim" . "nvim")
			      ("grep" . "grep --color=auto")
			      ("ip" . "ip -color=auto")
			      ("gitroot" . "cd $(git rev-parse --show-toplevel)")
			      ("gr" . "gitroot")))
		   (bashrc (list (plain-file "bashrc" %jtx/bashrc)))))

	 (service home-pipewire-service-type)
	 (service home-dbus-service-type)
	 
	 (service home-dotfiles-service-type
		  (home-dotfiles-configuration
		   (directories '("./dotfiles")))))))
