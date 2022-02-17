;;; ../../.backup/home/cc/.config/doom/bindings.el -*- lexical-binding: t; -*-

;; {{{ pdf view
(map! :map pdf-view-mode-map :desc "insert note at position" :n "i" #'org-noter-insert-note)
(map! :map pdf-view-mode-map :desc "scroll pdf left" :n "C-b" #'image-scroll-right)
(map! :map pdf-view-mode-map :desc "scroll pdf right" :n "C-f" #'image-scroll-left)
;; }}}

;; {{{ Leader map
(map! :leader :desc "find file in current workspace" :n "e" #'counsel-find-file)
(map! :leader :desc "ranger" :n "r" #'ranger)
(map! :leader :desc "toggle vterm" :n "j" #'+vterm/toggle)
;; search
(map! :leader :desc "git grep" :n "s g" #'counsel-git-grep)
;; files
(map! :leader :desc "kill buffer" :n "f k" #'kill-this-buffer)
;; window
(map! :leader :desc "ace the window" :n "w w" #'ace-window)
;; workspaces
(map! :n :desc "next workspace" :n "g t" #'+workspace/switch-right)
(map! :n :desc "previous workspace" :n "g T" #'+workspace/switch-left)
;; tabs
(map! :leader :desc "next tab" :n "TAB l" #'+tabs:next-or-goto)
(map! :leader :desc "previous tab" :n "TAB h" #'+tabs:previous-or-goto)
;; notes
(map! :leader :desc "org roam find node" :n "n f" #'org-roam-node-find)
(map! :leader :desc "org roam graph" :n "n g" #'org-roam-graph)

(map! :leader :desc "orgmode export options" :mode 'org-mode :n "c e" #'org-export-dispatch)

;; }}}
