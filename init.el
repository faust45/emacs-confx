
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

(load "visual-fill-column.el")
(load "ui.el")
(load "editing.el")
(load "go.el")

(setq-default modal-mode t)
(setq-default eldoc-mode -1)

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

(use-package geiser
  :bind (
	 :map modal-mode-map
	 ("C-," . geiser-pop-symbol-stack)
	 ("C-." . geiser-edit-symbol-at-point)
	 ;; ("C-x" . geiser-eval-definition)
	 ))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "30b14930bec4ada72f48417158155bc38dd35451e0f75b900febd355cda75c3e" "eb122e1df607ee9364c2dfb118ae4715a49f1a9e070b9d2eb033f1cefd50a908" "dea4b7d43d646aa06a4f705a58f874ec706f896c25993fcf73de406e27dc65ba" "82225f1fa1e4d3b00c63700f691fc0dc7c9bdab8a996e6a78f451f9a15bd74fc" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "3a9f65e0004068ecf4cf31f4e68ba49af56993c20258f3a49e06638c825fbfb6" "d1cbc62377e87ed73d97af40bf2bff23033bb29c44cc9f15ecbbcbb53fc88095" "ac58dc21b4f6ab0e2e31e3bcce38578f32b5f15a53a0ab08ee7118613d87d5fd" "cba5ebfabc6456e4bbd68e0394d176161e1db063c6ca24c23b9828af0bdd7411" "c7000071e9302bee62fbe0072d53063da398887115ac27470d664f9859cdd41d" default))
 '(package-selected-packages
   '(badger-theme clues-theme flatland-theme zenburn-theme tangotango-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized alect-themes ujelly-theme cloud-theme lush-theme lab-themes geiser-gambit lsp-mode chezmoi geiser-chez geiser-racket racket-mode flycheck-guile lsp-scheme slime quack ereader ox-epub geiser-mit circe exwm typing perfect-margin writeroom-mode dart-mode helm-ag magit centered-window geiser-guile speed-type pdf-tools eglot guix haskell-mode @ go-mode keyfreq use-package selectrum expand-region dash)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
