;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; miscellaneous {{
(package! wakatime-mode)
;; dict
;; (package! youdao-dictionary)
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


(package! arduino-mode :recipe (:host github :repo "bookest/arduino-mode"))

;; slack
;; (package! slack)

;; python {{
;; (package! company-jedi)
;; (package! lsp-jedi)
(package! jupyter)
;; elpy
(package! elpy)
(package! blacken)
;; flymake-ruff
;; (package! flymake-ruff :recipe
;;   (:host github :repo "erickgnavar/flymake-ruff" :branch "master"))
;; }}

;; pdf-tools
(unpin! pdf-tools)
(package! pdf-tools :recipe (:host github :repo "vedang/pdf-tools" :branch "master"))

;; matlab
(package! matlab-mode :recipe (:host github :repo "yuhonglin/matlab-mode"))

;; rust
(package! ob-rust :recipe (:host gitlab :repo "ajyoon/ob-rust"))

;; julia
(package! ob-julia :recipe (:host github :repo "gjkerns/ob-julia"))
(package! ox-ipynb :recipe (:host github :repo "jkitchin/ox-ipynb"))
(package! julia-formatter :recipe (:host github :repo "ki-chi/julia-formatter"))

;; plantuml
(package! plantuml-mode :pin "ea45a13707abd2a70df183f1aec6447197fc9ccc")
(when (featurep! :checkers syntax)
  (package! flycheck-plantuml :pin "183be89e1dbba0b38237dd198dff600e0790309d"))

;; pandoc import
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))

(package! smartparens)

(package! zotxt-emacs :recipe (:host github :repo "egh/zotxt-emacs"))
(package! deferred :recipe (:host github :repo "kiwanami/emacs-deferred"))

;; copilot
(package! copilot :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))

;; typst
(package! typst-ts-mode :recipe (:host sourcehut :repo "meow_king/typst-ts-mode"))

;; kdl
;; (package! kdl-ts-mode :recipe (:host github :repo "dataphract/kdl-ts-mode"))

;; alternative ipynb
(package! code-cells.el :recipe (:host github :repo "astoff/code-cells.el"))

(package! org-remoteimg :recipe (:host github :repo "gaoDean/org-remoteimg"))

(package! pet :recipe (:host github :repo "wyuenho/emacs-pet"))


;; cursor?
(package! aider :recipe (:host github :repo "tninja/aider.el" :branch "v0.10.0"))
