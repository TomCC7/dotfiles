;;; ../../dotfiles/.config/doom/helper.el -*- lexical-binding: t; -*-
;; some helper functions
(defun +save-buffer-as-is ()
  "Save file \"as is\", that is in read-only-mode."
  (interactive)
  (if buffer-read-only
      (save-buffer)
    (read-only-mode 1)
    (save-buffer)
    (read-only-mode 0)))
