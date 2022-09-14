(require 'project)

(add-hook 'go-mode-hook
  (lambda () 
     (make-face-unitalic 'font-lock-type-face)
     (make-face-unitalic 'font-lock-builtin-face)
     (add-hook 'before-save-hook #'gofmt-before-save)
     ;; (add-hook 'before-save-hook (lambda () (go-remove-unused-imports t)))
     (setq tab-width 4)
     (setq indent-tabs-mode 1)
     (define-key insert-mode-map (kbd ";") 'upper-case-next-char)))

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

