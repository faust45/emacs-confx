
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)

(when (window-system)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1))

(savehist-mode 1)

(set-cursor-color "steel blue")
(setq use-short-answers t)

(set-face-attribute 'default nil :height 130)
(set-frame-font "JetBrains Mono Bold 13" nil t)
(eval-after-load "faces"
  (progn
    (set-face-background 'mode-line "light slate gray")))
;; SteelBlue3

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; don't pop up font menu
;; no bell
(setq ring-bell-function 'ignore)

(setq split-width-threshold 0)
(load-theme 'dracula t)

(use-package perfect-margin
  :custom
  (perfect-margin-visible-width 90))

