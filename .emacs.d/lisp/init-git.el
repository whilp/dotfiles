;;; init-git --- Initialize git stuffs.

;;; Commentary:

;;; My git.

;;; Code:

(require 'use-package)
(require 'auth-source)
(require 'url-parse)
(require 'hydra)

(eval-when-compile
  ;; TODO: disabled because magit update
  ;; (require 'git-gutter-fringe+)
  (require 'cl)
  (require 'magit))

;; TODO: disabled because magit update
;; (use-package git-gutter-fringe+
;;   :ensure t
;;   :config
;;   (progn
;;     (global-git-gutter+-mode t)
;;     (git-gutter-fr+-minimal)
;;     (setq git-gutter+-lighter "")))

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
  :bind (("C-c C-g" . magit-dispatch-popup))
  :config
  (progn
    (autoload 'magit-status' "magit" nil t)
    
    (magit-define-popup-action
      'magit-dispatch-popup ?h "Github" 'whilp-github-popup)
    (magit-define-popup whilp-github-popup
      "Popup console for Github interaction."
      :actions  '((?p "Pull request" whilp-pull-request)
                  (?f "Fork" whilp-fork))
      :default-action 'whilp-pull-request)

    (defun whilp-pull-request ()
      "Open a Github pull request.

Run `hub pull-request' asynchronously; see
`whilp-pull-request-sentinel' for the interesting bits."
      (interactive)
      (set-process-sentinel
       (magit-run-git-with-editor "pull-request")
       'whilp-pull-request-sentinel))
    (defun whilp-pull-request-sentinel (process event)
      "Handle EVENT in PROCESS.

After `hub pull-request' exits, check the output logged in the magit
process log for a pattern that looks like a pull request URL and add
it to the kill ring."
      (magit-process-sentinel process event)
      (when (eq (process-status process) 'exit)
        (with-current-buffer (process-buffer process)
          (let* ((section (process-get process 'section))
                 (beg (marker-position (magit-section-content section)))
                 (end (marker-position (magit-section-end section)))
                 (content (buffer-substring beg end))
                 (match (string-match "http.*/pull/.*" content))
                 (url (match-string 0 content)))
            (kill-new url)))))
    (defun whilp-fork ()
      "Fork a Github repository."
      (interactive)
      (magit-run-git-async "fork"))

    (setq magit-git-executable (expand-file-name "~/bin/hub")
          magit-save-repository-buffers 'dontask
          magit-status-buffer-switch-function 'switch-to-buffer
          magit-completing-read-function 'magit-builtin-completing-read
          ;; helm--completing-read-default
          magit-revert-buffers 1
          magit-delete-by-moving-to-trash nil
          magit-diff-paint-whitespace nil)))

(provide 'init-git)
;;; init-git ends here
