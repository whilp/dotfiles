;;; init-git --- Initialize git stuffs.

;;; Commentary:

;;; My git.

;;; Code:

(require 'use-package)
(require 'auth-source)
(require 'url-parse)

(bind-keys :prefix-map whilp-git-map
           :prefix "s-g")

(use-package git-gutter-fringe+
  :ensure t
  :config
  (progn
    (require 'git-gutter-fringe+)
    (bind-keys :map whilp-git-map
               ("n" . git-gutter+-next-hunk)
               ("p" . git-gutter+-previous-hunk)
               ("=" . git-gutter+-show-hunk)
               ("r" . git-gutter+-revert-hunks)
               ("t" . git-gutter+-stage-hunks)
               ("C" . git-gutter+-stage-and-commit)
               ("G" . git-gutter+-stage-and-commit-whole-buffer)
               ("U" . git-gutter+-unstage-whole-buffer))

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

(use-package magit
  :ensure t
  :diminish magit-auto-revert-mode
  :config
  (progn
    (bind-keys :map whilp-git-map
               ("g" . magit-status)
               ("u" . magit-push)
               ("c" . magit-commit))
    (autoload 'magit-status' "magit" nil t)
    (setq magit-git-executable "gh"
          magit-save-some-buffers nil
          magit-status-buffer-switch-function 'switch-to-buffer
          magit-set-upstream-on-push 'dontask
          magit-completing-read-function 'magit-builtin-completing-read
          magit-last-seen-setup-instructions "1.4.0"
          magit-use-overlays nil)))

(provide 'init-git)
;;; init-git ends here