
(add-hook 'go-mode-hook
  (lambda () 
     (make-face-unitalic 'font-lock-type-face)
     (make-face-unitalic 'font-lock-builtin-face)
     (add-hook 'before-save-hook 'gofmt-before-save)
     (setq tab-width 4)
     (setq indent-tabs-mode 1)
     (define-key insert-mode-map (kbd ";") 'upper-case-next-char)))
