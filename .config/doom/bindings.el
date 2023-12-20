;;; ../../.backup/home/cc/.config/doom/bindings.el -*- lexical-binding: t; -*-

;; {{{ pdf view
(add-hook! 'pdf-view-mode-hook '(lambda ()
                                  (map! :map pdf-view-mode-map :desc "insert note at position" :n "i" #'org-noter-insert-note)
                                  (map! :map pdf-view-mode-map :desc "scroll pdf left" :n "C-b" #'image-scroll-right)
                                  (map! :map pdf-view-mode-map :desc "scroll pdf right" :n "C-f" #'image-scroll-left)))
;; }}}

;; cdlatex {{
;; disable stupid binding...
(map! :map cdlatex-mode-map "_" nil)
(map! :map cdlatex-mode-map "^" nil)
;; }}

;; {{{ Leader map
(map! :leader :desc "find file in current workspace" :n "e" #'find-file)
(map! :leader :desc "ranger" :n "r" #'deer)
(map! :leader :desc "toggle vterm" :n "j" #'+vterm/toggle)
(map! :leader :desc "jump to bookmark" :n "RET" #'bookmark-jump)
;; search
(map! :leader :desc "git grep" :n "s g" #'counsel-git-grep)
;; files
(map! :leader :desc "kill buffer" :n "f k" #'kill-this-buffer)
;; window
(map! :leader :desc "ace the window" :n "w w" #'ace-window)
(map! :leader :desc "split window" :n "w s" #'evil-window-split)
(map! :leader :desc "vsplit window" :n "w v" #'evil-window-vsplit)
(map! :leader :desc "window down" :n "w j" #'evil-window-down)
(map! :leader :desc "window up" :n "w k" #'evil-window-up)
(map! :leader :desc "window right" :n "w l" #'evil-window-right)
(map! :leader :desc "window left" :n "w h" #'evil-window-left)
(map! :leader :desc "window move down" :n "w J" #'+evil/window-move-down)
(map! :leader :desc "window move up" :n "w K" #'+evil/window-move-up)
(map! :leader :desc "window move right" :n "w L" #'+evil/window-move-right)
(map! :leader :desc "window move left" :n "w H" #'+evil/window-move-left)
;; workspaces
(map! :leader :desc "next tab" :n "TAB l" #'+workspace/switch-right)
(map! :leader :desc "previous tab" :n "TAB h" #'+workspace/switch-left)
;; notes
(map! :leader :desc "org roam find node" :n "n f" #'org-roam-node-find)
(map! :leader :desc "org roam graph" :n "n g" #'org-roam-graph)
(map! :leader :desc "org roam ui" :n "n u" #'org-roam-ui-open)
(map! :leader :desc "org noter kill session" :n "n k" #'org-noter-kill-session)

(map! :leader :desc "orgmode export options" :mode 'org-mode :n "c e" #'org-export-dispatch)

;; dict
;; (map! :leader :desc "search word from input"
;;       :n "d d" #'youdao-dictionary-search-from-input)
;; (map! :leader :desc "search word at point"
;;       :n "d p" #'youdao-dictionary-search-at-point-posframe)

;; org-babel excecute subtree
(map! :leader :desc "excecute babel in buffer"
      :mode 'org-mode :n "c b" #'org-babel-execute-buffer)

;; format buffer
;; (map! :mode 'julia-mode :leader :desc "julia format buffer"
;;        :n "c =" #'julia-format-buffer)
(map! :mode 'lsp-mode :leader :desc "lsp format buffer" :n "c =" #'lsp-format-buffer)

;; rust
(map! :leader :desc "rust run" :mode 'rust-mode :n "c c" #'lsp-rust-analyzer-run)

;; flymake
(map! :desc "flymake next error" :mode 'flymake-mode :n "g e" #'flymake-goto-next-error)
(map! :desc "flymake previous error" :mode 'flymake-mode :n "g E" #'flymake-goto-prev-error)

;; org-mode
(map! :desc "org next block" :mode 'org-mode :n "g n" #'org-next-block)
(map! :desc "org prev block" :mode 'org-mode :n "g p" #'org-previous-block)

;; dart
(map! :desc "flutter run or hot-reload"
      :leader :mode 'dart-mode :n "c c" #'flutter-run-or-hot-reload)
;; }}}
