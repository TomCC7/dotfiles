;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; miscellaneous {{
(package! wakatime-mode)
;; dict
(package! youdao-dictionary)
;; }}

;; {{ latex
;; auctex
(package! auctex)
;; cdlatex
(package! cdlatex)
;; koma-letter
(eval-after-load 'ox '(require 'ox-koma-letter))
;; }}

;; {{ org
(package! org-ref)

(unpin! org-roam)
(package! org-roam-ui)

(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
;; When using bibtex-completion via the `biblio` module
;; (unpin! bibtex-completion helm-bibtex ivy-bibtex)
;; }}


;; disable default snippets
(package! doom-snippets :ignore t)


(package! docker-tramp.el :recipe (:host github :repo "emacs-pe/docker-tramp.el"))

(package! arduino-mode :recipe (:host github :repo "bookest/arduino-mode"))

;; EAF {{
;; (package! emacs-application-framework
;;   :recipe (:host github :repo "manateelazycat/emacs-application-framework"
;;            :files ("eaf.el" "src/lisp/*.el")
;;            :build (:not compile)))
;; }}

;; slack
;; (package! slack)

;; python {{
;; (package! company-jedi)
(package! lsp-jedi)
(package! yapfify :recipe (:host github :repo "JorisE/yapfify"))
;; }}

;; pdf-tools
(unpin! pdf-tools)
(package! pdf-tools :recipe (:host github :repo "vedang/pdf-tools" :branch "master"))

;; matlab
(package! matlab-mode :recipe (:host github :repo "yuhonglin/matlab-mode"))
