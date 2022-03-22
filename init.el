
(require 'package)
(require 'project)

(setq package-enable-at-startup nil)
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa"  . "https://melpa.org/packages/")
                         ("tromey" . "http://tromey.com/elpa/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))


(setq load-path (cons "~/.config/emacs/customizations/" load-path))

;(setq gc-cons-threshold 10000000)
;(unless package-archive-contents
;    (package-refresh-contents))

(dolist (package '(use-package keyfreq dash dracula-theme))
 (unless (package-installed-p package)
         (package-install package)))

(setq use-package-always-ensure t)

(use-package orderless
  :ensure t
  :custom
  (setq orderless-skip-highlighting (lambda () selectrum-is-active))
  (setq selectrum-highlight-candidates-function #'orderless-highlight-matches)
  (completion-styles '(orderless)))


(use-package dracula-theme
  :config
  (progn
    (make-face-unitalic 'font-lock-type-face)
    (make-face-unitalic 'font-lock-builtin-face)))

(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(load "ui.el")
(load "editing.el")
(load "go.el")

(use-package selectrum
  :config (set-face-attribute 'selectrum-current-candidate nil
			      :foreground "yellow"
			      :background nil)
  
  :bind
  (:map selectrum-minibuffer-map
	("C-o" . selectrum-select-current-candidate)
	("C-e" . next-line)
     	("C-i" . previous-line)))

(use-package expand-region
  :bind (
	 :map modal-mode-map
	 ("p" . er/expand-region)))

 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c7000071e9302bee62fbe0072d53063da398887115ac27470d664f9859cdd41d" default))
 '(package-selected-packages
   '(haskell-mode @ go-mode keyfreq use-package selectrum expand-region dash)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
