(require 'rcirc)
(require 'auth-source)

(rcirc-track-minor-mode 1)

(setq rcirc-fill-flag nil
      rcirc-fill-column nil
      rcirc-time-format "%Y-%m-%dT%H:%M:%S "
      rcirc-log-flag t
      rcirc-log-directory (expand-file-name "~/.irclogs"))
;; rcirc-timeout-seconds

(setq rcirc-keywords
      '(
        "\\bSimpleFinance\\b"
        "\\bbackend[\\?!]"
        "\\bbackend\\b"
        "\\bchemex\\b"
        "\\bcoffee\\b"
        "\\bcowboy\\b"
        "\\beng\\b"
        "\\bmadison\\b"
        "\\bmaier\\b"
        "\\bmilwaukee\\b"
        "\\bmke\\b"
        "\\bmsn\\b"
        "\\bopa\\b"
        "\\bops\\b"
        "\\bpolish merge\\b"
        "\\brum club\\b"
        "\\bwhilip\\b"
        "\\bwisconsin\\b"
        "github.banksimple.com/it"
        "github.banksimple.com/ops"
        ))

(setq rcirc-omit-responses
      '(
        "324"
        "329"
        "332"
        "333"
        "353"
        "353"
        "477"
        "JOIN"
        "NICK"
        "PART"
        "QUIT"
        ))

(defun my-rcirc-mode-setup ()
  "Sets things up for channel and query buffers spawned by rcirc."
  ;; rcirc-omit-mode always *toggles*, so we first 'disable' it
  ;; and then let the function toggle it *and* set things up.
  (setq rcirc-omit-mode nil)
  (rcirc-omit-mode))

(add-hook 'rcirc-mode-hook 'my-rcirc-mode-setup)

(defun* my-rcirc-profile (host user port)
  (let* (
         (auth-info
          (car
           (auth-source-search
            :max 1
            :host host
            :user user
            :port port
            :create nil)))
         (password (funcall (plist-get auth-info :secret))))
    (list
     host
     :nick user
     :password (format "%s:%s" user password)
     :full-name user
     :port port
     :encryption 'tls)))

(setq rcirc-server-alist
      (list
;;       (my-rcirc-profile "chat.banksimple.com" "whilp" 9999)
       (my-rcirc-profile "furnace.firrre.com" "whilp" 9090)))
