;;; whilp-ui --- My preferred UI settings.

;;; Commentary:

;;; Opinions.

;;; Code:

(require 'use-package)

;; TODO
;; (bind-key "C-x C-c" nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package files
  :demand t
  :config (setq confirm-nonexistent-file-or-buffer nil))

(use-package startup
  :demand t
  :config
  (setq inhibit-startup-echo-area-message t
        inhibit-startup-message t))

(use-package window
  :demand t
  :config (setq recenter-positions '(top middle bottom)))

(setq ring-bell-function 'ignore
      visible-bell t)

(use-package fringe
  :demand t
  :config (fringe-mode '(nil . -1)))

(use-package menu-bar
  :demand t
  :config (menu-bar-mode -1))

(use-package scroll-bar
  :demand t
  :config (scroll-bar-mode -1))

(use-package tool-bar
  :demand t
  :config (tool-bar-mode -1))

(use-package winner
  :demand t
  :config (winner-mode 1))

(use-package battery
  :demand t
  :config (display-battery-mode 0))

(use-package which-func
  :demand t
  :config (which-function-mode 0))

;; no prompts.
(use-package subr
  :demand t
  :config (fset 'yes-or-no-p 'y-or-n-p))

;; syntax highlighting.
(use-package font-core
  :demand t
  :config (global-font-lock-mode t))

(provide 'whilp-ui)
;;; whilp-ui ends here
