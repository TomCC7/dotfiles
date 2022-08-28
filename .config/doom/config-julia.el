;;; ../../dotfiles/.config/doom/config-julia.el -*- lexical-binding: t; -*-

(after! org-mode
  (add-to-list 'org-babel-load-languages '(julia . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))

(use-package! julia-formatter
  :config
  ;; fix path issue
  (setf (cadr julia-executable-options)
      "--project=/home/cc/.emacs.d/.local/straight/repos/julia-formatter")
  (setq julia-formatter-server-path
        "/home/cc/.emacs.d/.local/straight/repos/julia-formatter/scripts/server.jl")
  (add-hook! 'julia-mode-hook #'julia-formatter-server-start))

(provide 'config-julia)
