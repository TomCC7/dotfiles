;;; config-python.el -*- lexical-binding: t; -*-
(setq ein:output-area-inlined-images t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((latex . t)
   (shell . t)
   (python . t)
   (ein . t)
   (lisp . t)))

(defun +conda/env-activate ()
  "set `conda-env-home-directory` before run `conda-env-activate`"
  (interactive)
  (setq conda-env-home-directory (expand-file-name "~/.conda/")
        conda-anaconda-home "/opt/anaconda")
  (conda-env-activate))

;; add jedi as company option
;; (defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))
;; (add-hook! 'python-mode-hook #'my/python-mode-hook)

;; configure jedi as lsp backend
(use-package! lsp-jedi
  :after lsp-mode
  :config
  (add-to-list 'lsp-disabled-clients 'pyright)
  (add-to-list 'lsp-enabled-clients 'jedi))

(provide 'config-python)
