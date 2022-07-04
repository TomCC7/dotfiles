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

;; use jedi for lsp-backend
(add-hook! 'python-mode-hook 'yapf-mode)
(use-package! lsp-jedi
    :after lsp-mode
    :config
    (add-to-list 'lsp-disabled-clients 'pyright)
    (add-to-list 'lsp-disabled-clients 'pyls))

(after! lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection
                    (lsp-tramp-connection "jedi-language-server")
                    :major-modes '(python-mode)
                    :remote? t
                    :server-id 'jedi-remote)))
(provide 'config-python)
