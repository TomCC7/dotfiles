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
 '(conda-anaconda-home "/home/cc/miniforge3"))

;; (use-package! flymake-ruff
;;   :hook
;;   (python-mode . flymake-mode)
;;   (python-mode . flymake-ruff-load)
;;   :config
;;   (custom-set-variables
;;    ;; '(python-check-command "ruff")
;;    '(flymake-start-on-save-buffer t)))

;; (use-package! lsp-jedi
;;   :after lsp-mode
;;   :config
;;   (add-to-list 'lsp-disabled-clients 'pyright)
;;   (add-to-list 'lsp-disabled-clients 'pyls)
;;   (add-to-list 'lsp-disabled-clients 'jedi)
;;   (after! lsp-mode
;;     (lsp-register-client
;;      (make-lsp-client :new-connection
;;                       (lsp-tramp-connection "jedi-language-server")
;;                       :major-modes '(python-mode)
;;                       :remote? t
;;                       :server-id 'jedi-tramp))))
(after! lsp-mode
  (add-to-list 'lsp-disabled-clients 'pyright)
  (add-to-list 'lsp-disabled-clients 'pyls)
  (add-to-list 'lsp-disabled-clients 'jedi)
  (add-to-list 'lsp-disabled-clients 'pyright-tramp)
  (add-to-list 'lsp-disabled-clients 'pyls-tramp)
  (add-to-list 'lsp-disabled-clients 'jedi-tramp)
  ;; diable pylsp lint
  (setq lsp-pylsp-plugins-pycodestyle-enabled nil
        lsp-pylsp-plugins-pyflakes-enabled nil
        lsp-pylsp-plugins-mccabe-enabled nil
        lsp-pylsp-plugins-pylint-enabled nil
        lsp-pylsp-plugins-flake8-enabled nil
        lsp-pylsp-plugins-mypy-enabled nil
        lsp-pylsp-plugins-pydocstyle-enabled nil)
  ;; (lsp-register-client
  ;;  (make-lsp-client :new-connection
  ;;                   (lsp-tramp-connection "pylsp")
  ;;                   :major-modes '(python-mode)
  ;;                   :remote? t
  ;;                   :server-id 'pylsp-tramp))
  )



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

;; code-cells.el
(use-package! code-cells
  :config
  (add-hook 'python-mode-hook 'code-cells-mode-maybe))

;; pet
(use-package! pet
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10))

(provide 'config-python)
