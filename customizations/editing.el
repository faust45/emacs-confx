;;; -*- lexical-binding: t; -*
;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.


(require 'use-package)
(require 'uniquify)
(require 'selectrum)
(require 'recentf)
(require 'saveplace)
(require 'modal-mode)

(setq uniquify-buffer-name-style 'forward)
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(setq recentf-max-menu-items 40)
(setq recentf-max-saved-items 300)
(setq save-place-file (concat user-emacs-directory "places"))
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default t)
(setq lazy-highlight t                 ; highlight occurrences
      lazy-highlight-cleanup nil       ; keep search term highlighted
      lazy-highlight-max-at-a-time nil ; all occurences in file
      isearch-allow-scroll t           ; continue the search even though we're scrolling
      )


(global-set-key (kbd "C-q") 'undo)
(global-set-key (kbd "C-f") 'undo-redo)

;;
;;(global-undo-fu-session-mode)
(savehist-mode 1)
(recentf-mode 1) 
(selectrum-mode +1)
;;(selectrum-prescient-mode +1)
;;(prescient-persist-mode +1)
(save-place-mode 1) 
;;(wrap-region-global-mode t)

(setq-default modal-mode t)
(setq-default common-keys-mode t)

(add-hook 'minibuffer-setup-hook 'disable-modal-and-common-modes)
(setq buffer-save-without-query t)

(modify-syntax-entry ?- "w" (standard-syntax-table))
(modify-syntax-entry ?_ "w" (standard-syntax-table))
;; (modify-syntax-entry ?: "c" (standard-syntax-table))
;; (modify-syntax-entry ?. " " (standard-syntax-table))

;; (face-attribute 'selectrum-current-candidate :background)

(setq lazy-highlight t                 ; highlight occurrences
      lazy-highlight-cleanup t       ; keep search term highlighted
      lazy-highlight-max-at-a-time nil ; all occurences in file
      isearch-allow-scroll t           ; continue the search even though we're scrolling
      )

(setq debug-on-error t)

(defun reload (n)
  (interactive "p")
  (load-file user-init-file)
  (message "Reloaded"))

(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]  
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))


;; (advice-add 'keyboard-quit :after #'x-indent)

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(defvar abbr-map
  '(keymap
    (?j . "Center(\nchild: $\n)")
    (?n . "Container(\nchild: $\n)")
    (?c . "Column(\nchildren: [\n$\n]\n)")
    (?e . "Expanded(\nchild: $\n)")
    (?p . "Padding(\npadding: EdgeInsets.only(left: 10, right: 10),\nchild: $\n)")
    (?i . "InkWell(\nchild: $,\nonTap: () {}\n)")
    (?r . "Row(\nchildren: [\n$\n]\n)")))

(defvar x-abbr-map
'(keymap
  (?f . "func () {\n\n}")
  ))

;; (add-hook 'go-mode-hook
;;           (lambda ()
;;             ))


