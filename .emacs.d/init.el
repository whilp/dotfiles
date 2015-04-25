;;; init --- Emacs initialization

;;; Commentary:

;;; My personal configuration.
;;; TODO:
;;;  - convert explicit (bind-keys) calls to :bind (after updating use-package)

;;; Code:

(setq load-prefer-newer t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
;;             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'auth-source)
  (require 'cl)
  (require 'color-theme)
  (require 'message)
  (require 'url)
  (require 'use-package))

(require 'bind-key)
(require 'diminish)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; TODO
;; http://blog.danielgempesaw.com/post/79353633199/installing-mu4e-with-homebrew-with-emacs-from
;; (use-package mu4e
;;   :ensure t
;;   :defer t)

(defconst whilp-full-name "Will Maier"
  "My name.")

(defconst whilp-email "wcmaier@gmail.com"
  "My preferred email.")

(use-package shell
  :demand t
  :config (setq explicit-shell-file-name "/bin/bash"))

(setq exec-path
      (append
       (mapcar
        'expand-file-name
        (list
         "~/bin"
         "~/go/bin"
         "~/homebrew/Cellar/go/1.3/libexec/bin"
         "/usr/local/opt/go/libexec/bin/godoc"
         "/usr/local/sbin"
         "/usr/local/bin"
         "/usr/local/MacGPG2/bin"
         ))
        exec-path))
(setenv "TMPDIR" "/tmp")
(setenv "PATH"
        (mapconcat 'identity exec-path path-separator))
(setenv "PAGER" "cat")
(setenv "EDITOR" "emacsclient")
(setenv "ALTERNATE_EDITOR" "emacs")
(setenv "PROMPT_COMMAND" "")
(setenv "GPG_AGENT_INFO" nil)
(setenv "SSH_AUTH_SOCK" (expand-file-name "~/.ssh/agent.sock"))
(setenv "PS1" "${debian_chroot:+($debian_chroot)}\\u@\\h:\\w \\$ ")
(setenv "_JAVA_OPTIONS" "-Djava.awt.headless=true")
(setenv "MAN_WIDTH" "72")

(setenv "GIT_EDITOR" "emacsclient")
(setenv "GIT_COMMITTER_NAME" whilp-full-name)
(setenv "GIT_COMMITTER_EMAIL" whilp-email)
(setenv "GIT_AUTHOR_NAME" whilp-full-name)
(setenv "GIT_AUTHOR_EMAIL" whilp-email)

(setenv "GOPATH" (expand-file-name "~/go"))

(use-package init-rcirc :demand t)
(use-package init-ui :demand t)
(use-package init-el-get :demand t)
(use-package init-dev :demand t)
(use-package init-org :demand t)

(use-package ace-jump-mode
  :ensure t
  :defer t
  :bind (("C-c SPC" . ace-jump-mode)))

(use-package markdown-mode
  :ensure t
  :defer t
  :config (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

(use-package auto-indent-mode
  :ensure t
  :demand t
  :config
  (setq auto-indent-start-org-indent t))

;; TODO
;; (use-package go-oracle)

(use-package deferred
  :ensure t
  :defer t)

(use-package async
  :ensure t
  :config
  (progn
    (require 'smtpmail-async)
    (setq ;;send-mail-function 'smtpmail-send-it
          ;;message-send-mail-function 'message-send-mail-with-sendmail
          send-mail-function 'async-smtpmail-send-it
          message-send-mail-function 'async-smtpmail-send-it
          )))

(use-package expand-region
  :ensure t
  :defer t
  :bind (("C-=" . er/expand-region)))

(use-package helm
  :ensure t
  :demand t
  :diminish helm-mode
  :bind (("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files))
  :config
  (progn
    (global-set-key (kbd "C-c h") 'helm-command-prefix)
    (global-unset-key (kbd "C-x c"))
    (setq helm-split-window-in-side-p t
          helm-move-to-line-cycle-in-source t
          helm-scroll-amount 8)
    (helm-mode 1)))

(use-package helm-semantic
  :demand t
  :config
  (setq helm-semantic-fuzzy-match t))

(use-package helm-command
  :demand t
  :config
  (setq helm-M-x-fuzzy-match t))

(use-package helm-buffers
  :demand t
  :config
  (setq helm-buffers-fuzzy-matching t))

(use-package helm-imenu
  :demand t
  :config
  (setq helm-imenu-fuzzy-match t))

(use-package helm-elisp
  :demand t
  :config
  (setq helm-apropos-fuzzy-match t
        helm-lisp-fuzzy-completion t))

(use-package helm-locate
  :demand t
  :config
  (setq helm-locate-fuzzy-match t))

(use-package helm-files
  :demand t
  :config
  (setq helm-ff-search-library-in-sexp t
        helm-recentf-fuzzy-match t
        helm-ff-file-name-history-use-recentf t))

(use-package helm-git-grep
  :ensure t
  :demand t
  :bind (("C-c g" . helm-git-grep))
  :config
  (progn
    (bind-keys :map isearch-mode-map ("C-c g" . helm-git-grep-from-isearch))
    (eval-after-load 'helm
      (bind-keys :map helm-map ("C-c g" . helm-git-grep-from-helm)))
    ))

(use-package projectile
  :ensure t
  :demand t
  :init (setq projectile-keymap-prefix (kbd "s-p"))
  :config
  (progn
    (bind-keys :map projectile-command-map
               ("!" . projectile-run-shell))

    (projectile-global-mode)

    (setq projectile-switch-project-action 'helm-projectile
          projectile-globally-ignored-directories
          (quote
           (
            ".idea"
            ".eunit"
            ".git"
            ".hg"
            ".fslckout"
            ".bzr"
            "_darcs"
            ".tox"
            ".svn"
            "build"
            "_workspace"))
          projectile-mode-line
          (quote
           (:eval (format " [%s]" (projectile-project-name)))))

    (defun projectile-run-shell (&optional buffer)
      "Start a shell in the project's root."
      (interactive "P")
      (projectile-with-default-dir (projectile-project-root)
        (shell (format "*shell %s*" (projectile-project-name)))))))

(use-package helm-projectile
  :ensure t
  :demand t
  :config
  (progn
    (setq projectile-completion-system 'helm
          helm-projectile-fuzzy-match t)
    (helm-projectile-on)
    (bind-keys :map projectile-command-map
               ("f" . helm-projectile-find-file-dwim)
               ("g" . helm-git-grep))))

(use-package helm-swoop
  :ensure t
  :bind (("M-i" . helm-swoop))
  :config
  (progn
    (defun whilp-helm-pre-input ()
      "")
    (setq helm-swoop-pre-input-function 'whilp-helm-pre-input)))

(use-package helm-descbinds
  :ensure t)

;; TODO
(use-package helm-dash
  :ensure t
  :demand t
  :config
  (setq helm-dash-browser-func 'eww))

(use-package git-gutter-fringe+
  :ensure t
  :config
  (progn
    (bind-keys :map git-gutter+-mode-map
               ("C-x n" . git-gutter+-next-hunk)
               ("C-x p" . git-gutter+-previous-hunk)
               ("C-x v =" . git-gutter+-show-hunk)
               ("C-x r" . git-gutter+-revert-hunks)
               ("C-x t" . git-gutter+-stage-hunks)
               ("C-x c" . git-gutter+-commit)
               ("C-x C" . git-gutter+-stage-and-commit)
               ("C-x C-y" . git-gutter+-stage-and-commit-whole-buffer)
               ("C-x U" . git-gutter+-unstage-whole-buffer))

    (global-git-gutter+-mode t)
    (git-gutter-fr+-minimal)
    (setq git-gutter+-lighter "")))

(use-package gh
  :ensure t
  :demand t
  :config
  (progn
    (defun* whilp-gh-profile (url user)
      (let* (
             (urlobj (url-generic-parse-url url))
             (host (url-host urlobj))
             (auth-info
              (car
               (auth-source-search
                :max 1
                :host host
                :user user
                :port 443
                :create nil)))
             (token (funcall (plist-get auth-info :secret))))
        (list
         :url url
         :username user
         :token token
         :remote-regexp (gh-profile-remote-regexp host))))

    (setq
     gh-profile-default-profile "bh"
     gh-profile-current-profile nil
     gh-profile-alist
     (list
      (cons "bh" (whilp-gh-profile "https://github.banksimple.com/api/v3" "whilp"))
      (cons "gh" (whilp-gh-profile "https://api.github.com" "whilp"))))))

(use-package gist
  :ensure t
  :defer t)

(use-package git-timemachine
  :ensure t
  :defer t)

(use-package git-link
  :ensure t
  :defer t)

(use-package ace-jump-buffer
  :ensure t
  :defer t)

(use-package ace-jump-mode
  :ensure t
  :defer t)

(use-package ace-jump-zap
  :ensure t
  :bind (("M-z" . ace-jump-zap-up-to-char-dwim)
         ("C-M-z" . ace-jump-zap-to-char-dwim)))

(use-package magit
  :ensure t
  :diminish magit-auto-revert-mode
  :config
  (progn
    (bind-keys :prefix-map whilp-magit-map
               :prefix "s-g"
               ("g" . magit-status)
               ("u" . magit-push)
               ("p" . magit-grep)
               ("c" . magit-commit))
    (autoload 'magit-status' "magit" nil t)
    (setq magit-git-executable "gh"
          magit-save-some-buffers nil
          magit-status-buffer-switch-function 'switch-to-buffer
          magit-set-upstream-on-push 'dontask
          magit-completing-read-function 'magit-builtin-completing-read
          magit-last-seen-setup-instructions "1.4.0"
          magit-use-overlays nil)))
  
(use-package yasnippet
  :ensure t
  :defer 60
  :diminish yas-minor-mode
  :config (yas-global-mode))

(use-package epa-file
  :config
  (progn
    (setq epa-file-name-regexp "\\.\\(gpg\\|asc\\)$"
          epa-armor t)
    (epa-file-name-regexp-update)
    (epa-file-enable)))

(use-package flyspell
  :diminish flyspell-mode)

;; TODO: migrate all these bits to separate libraries.
(require 'init-old)

(provide 'init)
;;; init ends here
