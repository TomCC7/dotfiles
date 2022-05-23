;;; ../../dotfiles/.config/doom/config-c.el -*- lexical-binding: t; -*-

(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"
                                "--compile-commands-dir=./build"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
;; remote lsp
(after! lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection
                    (lsp-tramp-connection '("clangd"
                                            "--compile-commands-dir=./build"))
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
