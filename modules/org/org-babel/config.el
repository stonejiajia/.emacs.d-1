;;; org/org-babel/config.el -*- lexical-binding: t; -*-
;;;

;(load! +scimax-org-babel-ipython)


(add-hook 'org-load-hook #'+org-babel|init t)

(defun +org-babel|init ()
  (setq org-src-fontify-natively t      ; make code pretty
        org-src-preserve-indentation t  ; use native major-mode indentation
        org-src-tab-acts-natively t
        org-src-window-setup 'current-window
        org-confirm-babel-evaluate nil) ; you don't need my permission

  (org-babel-do-load-languages
   'org-babel-load-languages
   (mapcar (lambda (sym) (cons sym t))
           '(calc
             css
             emacs-lisp
             haskell
             ipython
             js
             latex
             ledger
             lilypond
             lisp
             matlab
             plantuml
             python
             restclient ; ob-restclient
             ruby
             rust       ; ob-rust
             shell
             sml
             sqlite
             sql-mode   ; ob-sql-mode
             translate  ; ob-translate
             )))

  ;; In a recent update, `org-babel-get-header' was removed from org-mode, which
  ;; is something a fair number of babel plugins use. So until those plugins
  ;; update, this polyfill will do:
  (defun org-babel-get-header (params key &optional others)
    (cl-loop with fn = (if others #'not #'identity)
             for p in params
             if (funcall fn (eq (car p) key))
             collect p))

  ;; I prefer C-c C-c for confirming over the default C-c '
  (map! :map org-src-mode-map "C-c C-c" #'org-edit-src-exit)

  (defun +org|src-mode-remove-header ()
    "Remove header-line with keybinding help; I know the keybinds."
    (when header-line-format
      (setq header-line-format nil)))
  (add-hook 'org-src-mode-hook #'+org|src-mode-remove-header))





(setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block

;;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; Some use keybindings for org-src-block
(eval-after-load 'org
  '(progn
     (add-to-list 'org-structure-template-alist
                  '("ip" "#+BEGIN_SRC ipython :session :exports both :results raw drawer \n?\n#+END_SRC"
                    "<src lang=\"python\">\n?\n</src>"))

     (add-to-list 'org-structure-template-alist
	              '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"
	                "<src lang=\"emacs-lisp\">\n?\n</src>"))

     (add-to-list 'org-structure-template-alist
                  '("rr" "#+BEGIN_SRC R :exports both :results graphics :file ./fig_1?.png\n\n#+END_SRC"
                    "<src lang=\"?\">\n\n</src>"))

     (add-to-list 'org-structure-template-alist
                  '("ipf" "#+BEGIN_SRC ipython :session :file ./figure/fig_1?.png :exports both :results raw \n\n#+END_SRC"
                    "<src lang=\"?\">\n\n</src>"))

     (add-to-list 'org-structure-template-alist
                  '("sr" "#+BEGIN_SRC R :exports both :session \n\n#+END_SRC"
                    "<src lang=\"?\">\n\n</src>"))
     ))
