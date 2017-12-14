;;; lang/sml/config.el -*- lexical-binding: t; -*-

(def-package! sml-mode
  :mode "\\.sml$")

(setenv "PATH" (concat "/usr/local/smlnj/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/smlnj/bin"  exec-path))
