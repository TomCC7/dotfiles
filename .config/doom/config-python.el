;;; config-python.el -*- lexical-binding: t; -*-
;; elpy
(use-package! elpy
  :ensure t
  :hook
  (python-mode . (lambda ()
                 (add-hook! 'before-save-hook #'elpy-black-fix-code)
                 (map! :map 'python-mode-map :leader :desc "elpy format buffer" :n "c =" #'elpy-black-fix-code)))
  :init
  (elpy-enable)
  :config
  (custom-set-variables
   '(python-check-command "ruff")
   '(elpy-syntax-check-command "ruff")))

;; ruff support for flymake
(use-package! flymake-ruff
  :ensure t
  :hook
  (python-mode . flymake-ruff-load))

;; conda
(defun +conda/env-activate ()
  "Set `conda-env-home-directory` before run `conda-env-activate`."
  (interactive)
  (setq conda-env-home-directory (expand-file-name "~/.conda/")
        conda-anaconda-home "/opt/anaconda")
  (conda-env-activate))

;; use jedi for lsp-backend
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

;; load emacs-jupyter
(use-package! jupyter
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (jupyter . t)))
  (setq ob-async-no-async-languages-alist '("jupyter-python" "jupyter-julia"))
  )

(use-package! ob-jupyter
  :config
  ;; use LANG intead of jupyter-LANG in src block
  (org-babel-jupyter-override-src-block "python")
  (org-babel-jupyter-override-src-block "julia"))

;; poetry
(setq poetry-tracking-strategy 'projectile)

(provide 'config-python)
