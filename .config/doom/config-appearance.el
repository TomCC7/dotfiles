;;; config-appearance.el -*- lexical-binding: t; -*-

;; {{ Appearance
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "MesloLGS Nerd Font Mono" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "monospace") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "MesloLGS Nerd Font Mono" :size 16)
      doom-big-font (font-spec :family "MesloLGS Nerd Font Mono" :size 21))
;; theme
(setq doom-theme 'doom-one)
;; }}

;; {{ prettify-symbols-mode
(defconst lisp--prettify-symbols-alist
  '(("lambda"  . ?λ)
    ("->" . ?→)
    ("->>" . ?↠)
    ("=>" . ?⇒)
    ("/=" . ?≠)
    ("!=" . ?≠)
    ("==" . ?≡)
    ("<=" . ?≤)
    (">=" . ?≥)
    ("&&" . ?∧)
    ("||" . ?∨)
    ("not" . ?¬)
    (">=" . ?≥)
    ))
(global-prettify-symbols-mode 1)

(add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (push '(">=" . ?≥) prettify-symbols-alist)))
(setq display-line-numbers 'relative)
;; }}
