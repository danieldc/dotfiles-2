;; Enable emacs' built-in package manager, and make sure certain packages are present 

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

;; Source: http://stackoverflow.com/a/10095853/580206
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Make sure we always have these packages
(ensure-package-installed 'evil
				'projectile
				'magit
				'helm
				'python-django
				'minitest
				'ag
				'color-theme
				'solarized-theme
				;; Via http://www.lambdacat.com/post-modern-emacs-setup-for-erlang/
				'popup
				'company
				'flycheck
				'flycheck-tip
				; 'flycheck-rust
    )

;; Vim is still the better text editor
(require 'evil)
(evil-mode t)


;; (load-theme 'solarized-dark t)
(load-theme 'solarized-light t)

;; Remove the toolbar
(tool-bar-mode -1)

;; Automatically follow symlinks
;; If set to 'nil', it won't "follow" the symlink, and edit it in place.
;; However, version control related stuff won't be available
(setq vc-follow-symlinks t)

;; Make the Emacs window maximized on startup
(toggle-frame-maximized)


;; Set up shortcuts to resize frames
(global-set-key (kbd "C-x <up>") 'enlarge-window)
(global-set-key (kbd "C-x <down>") 'shrink-window)
(global-set-key (kbd "C-x <C-up>") 'enlarge-window)
(global-set-key (kbd "C-x <C-down>") 'shrink-window)


;; Configure python mode
; (defun configure-python-mode
;    (setq python-indent-offset 2))
;
; (add-hook 'python-mode-hook 'configure-python-mode)


;; Configure flycheck
(require 'flycheck)

; Flycheck setup here

;; Get Flycheck messages as tool tips
(require 'flycheck-tip)
(flycheck-tip-use-timer 'verbose)


;; Enable Autocomplete
(add-hook 'after-init-hook 'global-company-mode)
