;;; ../../dotfiles/.config/doom/config-c.el -*- lexical-binding: t; -*-

(setq lsp-clients-clangd-args '("-j=6"
                                "--background-index"
                                "--compile-commands-dir=./build"))
(setq lsp-tramp-command lsp-clients-clangd-args)
(push "clangd" lsp-tramp-command)
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
;; remote lsp
(after! lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection
                    (lsp-tramp-connection lsp-tramp-command)
                    :major-modes '(c-mode c++-mode)
                    :remote? t
                    :server-id 'clangd-remote))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "cmake-language-server")
                    :major-modes '(cmake-mode)
                    :remote? t
                    :server-id 'cmakels-remote)))

;; also arduino
(use-package! arduino-mode)
(provide 'config-c)
