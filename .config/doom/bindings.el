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
(map! :leader :desc "next tab" :n "TAB l" #'+workspace/switch-right)
(map! :leader :desc "previous tab" :n "TAB h" #'+workspace/switch-left)
;; notes
(map! :leader :desc "org roam find node" :n "n f" #'org-roam-node-find)
(map! :leader :desc "org roam graph" :n "n g" #'org-roam-graph)

(map! :leader :desc "orgmode export options" :mode 'org-mode :n "c e" #'org-export-dispatch)

;; dict
(map! :leader :desc "search word from input" :n "d d" #'youdao-dictionary-search-from-input)
(map! :leader :desc "search word at point" :n "d p" #'youdao-dictionary-search-at-point-posframe)

;; org-babel excecute subtree
(map! :leader :desc "excecute codes in the subtree"
      :mode 'org-mode :n "c b" #'org-babel-execute-subtree)

;; }}}
