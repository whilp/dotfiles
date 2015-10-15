;;; init-dev --- Initialize development environment

;;; Commentary:

;;; My dev env
;;; TODO:
;;; - Add M-, / M-. for each runtime

;;; Code:

(require 'use-package)
(require 'init-shell)

(defvar eir-key "C-<return>"
  "Eval-in-REPL key.")

(use-package edit-server-htmlize
  :ensure t
  :config
  (progn
    (setq edit-server-new-frame nil)
    (edit-server-start)))

(use-package yaml-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'")

(use-package cask
  :ensure t)

(use-package prog-mode
  :demand t
  :diminish auto-fill-function
  :config
  (add-hook 'prog-mode-hook 'turn-on-auto-fill))

(use-package newcomment
  :config
  (setq comment-auto-fill-only-comments t))

(use-package comment-dwim-2
  :ensure t
  :bind ("M-;" . comment-dwim-2))

(use-package lua-mode
  :ensure t
  :mode "\\.lua\\'")

(use-package eval-in-repl
  :ensure t)

(use-package graphviz-dot-mode
  :ensure t)

(use-package clojure-mode
  :ensure t
  :demand t)

(use-package json-mode
  :ensure t
  :mode "\\.json\\'"
  :config
  (progn
    (use-package js :demand t)
    (defun whilp-json-mode-hook ()
      (interactive)
      (setq js-indent-level 2))

    (add-hook 'json-mode-hook 'whilp-json-mode-hook)
    (add-hook 'js-mode-hook 'whilp-json-mode-hook)))

(use-package lisp-mode
  :config
  (bind-keys :map emacs-lisp-mode-map
             ("M-." . find-function-at-point)))

(use-package eldoc
  :demand t
  :diminish eldoc-mode
  :config
  (dolist (hook '(emacs-lisp-mode-hook
                  lisp-interaction-mode-hook
                  ielm-mode-hook
                  python-mode-hook
                  ))
    (add-hook hook 'eldoc-mode)))

(use-package company
  :ensure t
  :diminish company-mode
  :init (global-company-mode 1)
  :config
  (progn
    (dolist (package '(company-go))
      (use-package package
        :ensure t
        :demand t
        :init (add-to-list 'company-backends package)))
    (setq company-auto-complete t
          company-echo-delay 5
          company-tooltip-minimum-width 30
          company-idle-delay nil)))

;; (use-package inf-ruby
;;   :ensure t
;;   :defer t
;;   :config
;;   (progn
;;     (setq ruby-deep-indent-paren nil
;;           ruby-deep-arglist nil)))

(use-package js2-mode
  :ensure t
  :defer 1
  :mode ("\\.(json|js)$" . js-mode)
  :config
  (add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2))))

;; go get github.com/rogpeppe/godef
(use-package go-mode
  :mode "\\.go"
  :ensure t
  :config
  (progn
    (bind-keys :map go-mode-map
               ("C-c C-d" . godoc-at-point))
    ;; go get code.google.com/p/go.tools/cmd/oracle
    (add-to-list 'load-path
                 (concat whilp-gopath "src/code.google.com/p/go.tools/cmd/oracle/"))
    (setq compilation-error-regexp-alist
          (cons 'go-test compilation-error-regexp-alist))
    (use-package go-oracle
      :init (load "oracle")
      :config
      (progn
        (setq go-oracle-command (executable-find "oracle"))
        (add-hook 'go-mode-hook 'go-oracle-mode)))
    (use-package go-eldoc
      :ensure t
      :config (add-hook 'go-mode-hook 'go-eldoc-setup))
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook #'gofmt-before-save)
    (bind-keys :map go-mode-map
               ("M-." . godef-jump))))

(use-package restclient
  :ensure t
  :defer t)

;; (use-package minitest
;;   :ensure t
;;   :defer t)

(use-package scala-mode2
  :ensure t
  :defer t)

(use-package flycheck
  :ensure t
  :config
  (progn
    (define-key flycheck-mode-map flycheck-keymap-prefix nil)
    (setq flycheck-keymap-prefix (kbd "C-c f"))
    (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map)
    (setq-default flycheck-emacs-lisp-load-path load-path)
    (global-flycheck-mode)))

;; (use-package rubocop
;;   :ensure t
;;   :defer t
;;   :config
;;   (progn
;;     (require 'flycheck)
;;     (add-hook 'ruby-mode-hook 'rubocop-mode)
;;     (eval-after-load 'flycheck
;;       (flycheck-add-next-checker 'chef-foodcritic 'ruby-rubocop))))

;; (use-package mmm-mode
;;   :ensure t
;;   :commands mmm-mode
;;   :config
;;   (progn
;;     (setq mmm-global-mode 'buffers-with-submode-classes
;;           mmm-submode-decoration-level 0)
;;     (use-package mmm-auto)))

(use-package csv-mode
  :ensure t
  :mode "\\.[Cc][Ss][Vv]\\'"
  :init (setq csv-separators '("," ";" "|" " "))
  :config (use-package csv-nav :ensure t))

(use-package python
  :ensure t
  :mode (("\\.py\\'" . python-mode)
         ("BUILD.*" . python-mode))
  :config
  (progn
    (setq python-shell-interpreter "ipython"
          python-shell-interpreter-args "-i")
    (bind-keys :map python-mode-map
               (eir-key . eir-eval-in-python))
    
    ;; (use-package elpy
    ;;   :ensure t
    ;;   :config
    ;;   (progn
    ;;     ;; Remove elpy company configuration; I like my own.
    ;;     (setq elpy-modules
    ;;           (remove 'elpy-module-company elpy-modules))
    ;;     (elpy-enable)
    ;;     (elpy-use-ipython)))
    ;; (use-package pyenv-mode
    ;;   :ensure t))
    ))

;; (use-package ein
;;   :ensure t)

(use-package ruby-mode
  :ensure t
  :commands ruby-mode
  :mode (("Gemfile\\'" . ruby-mode)
         ("\\.builder\\'" . ruby-mode)
         ("\\.gemspec\\'" . ruby-mode)
         ("\\.irbrc\\'" . ruby-mode)
         ("\\.pryrc\\'" . ruby-mode)
         ("\\.rake\\'" . ruby-mode)
         ("\\.ru\\'" . ruby-mode)
         ("\\.rxml\\'" . ruby-mode))
  :init
  (setq ruby-use-encoding-map nil)
  :config
  (progn
    ;; (dolist (package '(ruby-hash-syntax
    ;;                    ruby-compilation
    ;;                    bundler))
    ;;   (use-package package :ensure t))
    ;; (use-package inf-ruby
    ;;   :ensure t
    ;;   :config
    ;;   (setq inf-ruby-default-implementation "pry"))
    ;; (bind-keys :map ruby-mode-map
    ;;            ("RET" . reindent-then-newline-and-indent)
    ;;            ("TAB" . indent-for-tab-command)
    ;;            (eir-key . eir-eval-in-ruby))
    
    (add-hook 'ruby-mode-hook 'subword-mode)
    
    ;; (use-package robe
    ;;   :ensure t
    ;;   :init
    ;;   (progn
    ;;     (with-eval-after-load 'company
    ;;       (push 'company-robe company-backends))
    ;;     (add-hook 'ruby-mode-hook 'robe-mode)))

    ;; (use-package yari
    ;;   :ensure t
    ;;   :init (defalias 'ri 'yari))

    ;; (use-package rinari
    ;;   :ensure t
    ;;   :init (global-rinari-mode))

    ;; (use-package rspec-mode
    ;;   :ensure t
    ;;   :config
    ;;   (add-hook 'ruby-mode-hook (lambda () (rspec-mode 1))))

    ;; Stupidly the non-bundled ruby-mode isn't a derived mode of
    ;; prog-mode: we run the latter's hooks anyway in that case.
    (add-hook 'ruby-mode-hook
              (lambda ()
                (unless (derived-mode-p 'prog-mode)
                  (run-hooks 'prog-mode-hook))))))

(use-package pp
  :demand t
  :config
  (progn
    (global-set-key [remap eval-expression] 'pp-eval-expression)
    (global-set-key [remap eval-last-sexp] 'pp-eval-last-sexp)))

;; TODO: essh https://github.com/svend/emacs-essh

(use-package compile
  :demand t
  :config
  (setq compilation-scroll-output t
        compilation-read-command nil
        compilation-ask-about-save nil
        compilation-auto-jump-to-first-error nil
        compilation-save-buffers-predicate nil))

(use-package vc-hooks
  :demand t
  :config
  (bind-keys :map vc-prefix-map ("=" . ediff-revision)))

(use-package ediff
  :demand t
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

(provide 'init-dev)
;;; init-dev ends here
