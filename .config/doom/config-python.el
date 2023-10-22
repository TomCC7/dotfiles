;;; config-python.el -*- lexical-binding: t; -*-
;; elpy
;; (use-package! elpy
;;   :ensure t
;;   :hook
;;   (python-mode . (lambda ()
;;                    (add-hook! 'before-save-hook
;;                               #'(lambda () (if (eq major-mode 'python-mode)
;;                                    (elpy-black-fix-code))))
;;                    (map! :map 'python-mode-map :leader :desc "elpy format buffer" :n "c =" #'elpy-black-fix-code)))
;;   :init
;;   ;; (elpy-enable)
;;   :config
;;   (custom-set-variables
;;    '(python-check-command "ruff")
;;    '(elpy-syntax-check-command "ruff")))

(custom-set-variables
 '(conda-anaconda-home "/opt/anaconda/"))

(use-package! flymake-ruff
  :hook
  (python-mode . flymake-mode)
  (python-mode . flymake-ruff-load)
  :config
  (custom-set-variables
   '(python-check-command "ruff")
   '(flymake-start-on-save-buffer t)))

(use-package! blacken
  :ensure t
  :hook
  (python-mode . blacken-mode)
  :config
  (setq blacken-only-if-project-is-blackened t)
  (map! :mode 'python-mode :leader :desc "blacken buffer" :n "c =" #'blacken-buffer))

(use-package! lsp-jedi
  :after lsp-mode
  :config
  (add-to-list 'lsp-disabled-clients 'pyright)
  (add-to-list 'lsp-disabled-clients 'pyls)
  (after! lsp-mode
    (lsp-register-client
     (make-lsp-client :new-connection
                      (lsp-tramp-connection "jedi-language-server")
                      :major-modes '(python-mode)
                      :remote? t
                      :server-id 'jedi-remote))))


;; load emacs-jupyter
(use-package! jupyter
  :init
  (setenv "PYDEVD_DISABLE_FILE_VALIDATION" "1")
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (jupyter . t)))
  (setq ob-async-no-async-languages-alist '("jupyter-python" "jupyter-julia"))
  (setq org-babel-default-header-args:jupyter-julia '((:async . "yes")
                                                      (:kernel . "julia")))
  (setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                       (:kernel . "python")))
  (defun jupyter-ansi-color-apply-on-region (begin end)
    (ansi-color-apply-on-region begin end t)))

(use-package ob-jupyter
  :config
  ;; use LANG intead of jupyter-LANG in src block
  (org-babel-jupyter-override-src-block "python")
  (org-babel-jupyter-override-src-block "julia"))

;; poetry
(setq poetry-tracking-strategy 'projectile)

(provide 'config-python)
