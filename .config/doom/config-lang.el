;;; ../../dotfiles/.config/doom/config-lang.el -*- lexical-binding: t; -*-
;; plantuml {{
(use-package! plantuml-mode
  :commands plantuml-download-jar
  :init
  (setq plantuml-jar-path (concat doom-etc-dir "plantuml.jar")
        org-plantuml-jar-path plantuml-jar-path)
  :config
  (set-popup-rule! "^\\*PLANTUML" :size 0.4 :select nil :ttl 0)

  (setq plantuml-default-exec-mode
        (cond ((file-exists-p plantuml-jar-path) 'jar)
              ((executable-find "plantuml") 'executable)
              (plantuml-default-exec-mode))))


(use-package! flycheck-plantuml
  :when (featurep! :checkers syntax)
  :after plantuml-mode
  :config (flycheck-plantuml-setup))


(after! ob-plantuml
  (add-to-list 'org-babel-default-header-args:plantuml
               '(:cmdline . "-charset utf-8")))
;; nixos specific
(setq org-plantuml-jar-path "/run/current-system/sw/lib/plantuml.jar")
;; }}

(provide 'config-lang)
