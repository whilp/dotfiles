(projectile-global-mode)

(setq projectile-mode-line '(
                             :eval (format " [%s]" (projectile-project-name))))
(define-key whilp/bindings-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)

