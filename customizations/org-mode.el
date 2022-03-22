



(evil-define-key 'normal org-mode-map (kbd "C-n") 'org-cycle)
(evil-define-key 'normal org-mode-map (kbd "M-j") 'org-shiftright)


(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "cyan" :weight bold))
	("STARTED" . "yellow")
        ("CANCELED" . (:foreground "blue" :weight bold))))


