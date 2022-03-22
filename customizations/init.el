;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)


(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
;(package-initialize)

;(load "navigation.el")
(load "dart.el")
(load "ui.el")
(load "editing.el")
;(load "lisp-editing.el")
;(load "misc.el")



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("aa6638f0cd2ba2c68be03220ea73495116dc6f0b625405ede34087c1babb71ae" "039c01abb72985a21f4423dd480ddb998c57d665687786abd4e16c71128ef6ad" "c5692610c00c749e3cbcea09d61f3ed5dac7a01e0a340f0ec07f35061a716436" "f99318b4b4d8267a3ee447539ba18380ad788c22d0173fc0986a9b71fd866100" "5111a41453244802afd93eed1a434e612a8afbdf19c52384dffab129258bab6e" "6df412e59dbfe7f72f24319b9ee4513e40bb0e44384fc93a2c77399e641348f6" "fa96a61e4eca5f339ad7f1f3442cb5a83696f6a45d9fe2a7bf3b75fc6912bb91" "53fc4871f519e34fd25604a5391272527b2dbb4e365b97615615e5bb8c9f16b6" "602c523efed33ab7bc708c31ed9d641abe123e2bfbbe124e46faf68c95e67d8d" "515e9dd9749ef52a8e1b63427b50b4dc68afb4a16b1a9cabfbcf6b4897f2c501" "21388667ce5ee0b375e6282f0d6c6b61588da6604d343bbb19389e6a54d3d00d" "c7f364aeea0458b6368815558cbf1f54bbdcc1dde8a14b5260eb82b76c0ffc7b" default))
 '(electric-indent-mode nil)
 '(package-selected-packages
   '(wrap-region aggressive-indent flutter eglot company posframe autumn-light-theme leuven-theme night-owl-theme warm-night-theme jazz-theme tango-2-theme dash-functional undo-fu-session undo-fu ace-window use-package google-this modus-themes expand-region avy selectrum)))
