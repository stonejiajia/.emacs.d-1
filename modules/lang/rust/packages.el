;; -*- no-byte-compile: t; -*-
;;; lang/rust/packages.el

;; requires rust cargo racer

(package! racer)
(package! rust-mode)

(package! lsp-mode :recipe (:fetcher github :repo "emacs-lsp/lsp-mode"))
(package! lsp-rust :recipe (:fetcher github :repo "emacs-lsp/lsp-rust"))



(when (featurep! :feature syntax-checker)
  (package! flycheck-rust))

(when (featurep! :completion company)
  (package! company-racer))
