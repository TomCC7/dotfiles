;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "CC"
      user-mail-address "playercc7@gmail.com")
(load! "bindings")
(load! "config-appearance")


;; fill column
(setq fill-column 80)
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; {{{ORG
(setq org-roam-directory (file-truename "/home/cc/Documents/emacs/roam"))
(setq org-noter-always-create-frame nil)
;; }}

(setq-default bookmark-default-file "/home/cc/.config/doom/bookmarks")

;; {{ org-latex
;; (use-package! auctex)
(use-package! cdlatex)
;; preview size
(add-hook 'org-mode-hook #'turn-on-cdlatex)
;; {{ export org-mode in Chinese into PDF
;; @see http://freizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
(setq org-latex-pdf-process
      ;; '("pdflatex -interaction nonstopmode -output-directory %o %f"
      ;;   ;; "biber %b"
      ;;   "pdflatex -interaction nonstopmode -output-directory %o %f"
      ;;   "pdflatex -interaction nonstopmode -output-directory %o %f"))

      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f")) ;; org v8

(add-hook 'org-mode-hook
          (lambda ()
            (setq org-format-latex-options
                  (plist-put org-format-latex-options :scale 0.6))))
;; (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

;; export with minted
(setq org-latex-listings 'minted)
;; }}

;; {{ yasnippet
(setq yas-snippet-dirs '("/home/cc/.config/doom/snippets"))
;; }}
;; {{ emacsql
(setq emacsql-sqlite-executable "/home/cc/.guix-home/profile/bin/emacsql-sqlite")
;; }}


;; python
(load! "config-python")
