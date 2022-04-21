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
(setq org-roam-directory (file-truename "~/Documents/emacs/roam"))
(setq org-noter-always-create-frame nil)
(setq org-noter-notes-search-path '("~/Documents/emacs/papers/notes"))

;; org-ref
(setq bibtex-completion-bibliography '("~/Documents/emacs/citation.bib")
      bibtex-completion-library-path '("~/Documents/emacs/papers")
      bibtex-completion-notes-path "~/Documents/emacs/papers/notes"
      bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

      bibtex-completion-additional-search-fields '(keywords)
      bibtex-completion-display-formats
      '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
        (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
        (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
        (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
        (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
      bibtex-completion-pdf-open-function
      (lambda (fpath)
	(call-process "open" nil 0 nil fpath)))
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

;; {{ mu4e
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(setq +mu4e-gmail-accounts '(("playercc7@gmail.com" . "/playercc7")))
;; don't need to run cleanup after indexing for gmail
(setq mu4e-index-cleanup nil
      ;; because gmail uses labels as folders we can use lazy check since
      ;; messages don't really "move"
      mu4e-index-lazy-check t)
(set-email-account! "gmail.com"
  '((mu4e-sent-folder       . "/gmail.com/Sent Mail")
    (mu4e-drafts-folder     . "/gmail.com/Drafts")
    (mu4e-trash-folder      . "/gmail.com/Trash")
    (mu4e-refile-folder     . "/gmail.com/All Mail")
    (smtpmail-smtp-user     . "playercc7@gmail.com")
    ;; (user-mail-address      . "foo@bar.com") only needed for mu < 1.4
    (mu4e-compose-signature . "---\nYours truly\n Che Chen"))
  t)
;; }}

;; enable wakatime
(global-wakatime-mode)

;; c
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; python
(load! "config-python")
;; keys
(load! "keys")
