

(setq repl-win nil)
(setq repl-buffer-name nil)
(setq repl-eval-fn nil)

(add-hook 'inf-ruby-minor-mode-hook
	  (lambda ()
	    (setq-local repl-eval-fn #'ruby-send-line)
	    (setq-local repl-buffer-name "*rails*")))

(add-hook 'inf-clojure-minor-mode-hook
	  (lambda ()
	    (setq-local repl-eval-fn #'inf-clojure-eval-defun)
	    (setq-local repl-buffer-name "*inf-clojure*")))

(if (bound-and-true-p inf-clojure-minor-mode)
  (message "flymake-mode is on")
  (message "flymake-mode is off"))

(defun repl-show ()
  (let ((repl-w (display-buffer-in-side-window (get-buffer repl-buffer-name)
                                               '(side bottom))))
    (setq repl-win repl-w)))

(defun repl-toggle ()
  (interactive)
  (if repl-win
      (progn
        (delete-window repl-win)
        (setq repl-win nil))
    (repl-show)))

(defun repl-eval ()
  (interactive)
  (funcall repl-eval-fn)
  (repl-show))

(define-key evil-motion-state-map (kbd "C-e") nil)

(with-eval-after-load 'elisp-mode
  (define-key emacs-lisp-mode-map (kbd "C-e") 'eval-defun))

(with-eval-after-load 'inf-ruby
  (define-key inf-ruby-minor-mode-map (kbd "C-e") 'repl-eval))

(with-eval-after-load 'inf-clojure
  (evil-define-key 'normal inf-clojure-minor-mode-map
    (kbd "C-e") 'inf-clojure-eval-defun)
  (evil-define-key 'normal inf-clojure-minor-mode-map
    (kbd "C-c p") 'reload-current-clj-ns))

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "C-w d") 'repl-toggle))

(add-hook 'clojure-mode-hook 'inf-clojure-minor-mode)
;(define-key evil-motion-state-map (kbd "C-e") nil)
;(setq inf-clojure-custom-startup '("localhost" . 8001))
(setq inf-clojure-custom-startup "clojure")
;(setq inf-clojure-custom-startup "clojure -A:ncljs mrepl.clj")

(defun reload-current-clj-ns (next-p)
  (interactive "P")
  (save-buffer)
  (let ((ns (clojure-find-ns))
	(force-render "(in-ns 'astra.state) (force-re-render)"))
        (message (format "Loading %s ..." ns))
	(inf-clojure-eval-string (format "(require '%s :reload)" ns))
	(inf-clojure-eval-string force-render)
        (message (format "%s was reloaded!" ns))
    (when (not next-p) (inf-clojure-eval-string (format "(in-ns '%s)" ns)))))


(defvar parameters
  '(window-parameters . ((no-other-window . t)
                         (no-delete-other-windows . t))))
     
(setq display-buffer-alist
      '(("*rails*"
         display-buffer-in-side-window
         (side . bottom) (slot . 0) (window-height . 5)
         (preserve-size . (nil . t)) ,parameters)
	("*inf-clojure*"
         display-buffer-in-side-window
         (side . bottom) (slot . 0) (window-height . 5)
         (preserve-size . (nil . t)) ,parameters)))

(defun ruby-send-region (start end &optional print)
  "Send the current region to the inferior Ruby process."
  (interactive "r\nP")
  (let (term (file (or buffer-file-name (buffer-name))) line)
    (save-excursion
      (save-restriction
        (widen)
        (goto-char start)
        (setq line (+ start (forward-line (- start)) 1))
        (goto-char start)
        (while (progn
                 (setq term (apply 'format ruby-send-terminator (random) (current-time)))
                 (re-search-forward (concat "^" (regexp-quote term) "$") end t)))))
    ;; compilation-parse-errors parses from second line.
    (save-excursion
      (let ((m (process-mark (inf-ruby-proc))))
        (set-buffer (marker-buffer m))
        (goto-char m)
        (insert ruby-eval-separator "\n")
        (set-marker m (point))))
    '(comint-send-string (inf-ruby-proc) (format "eval <<'%s', %s, %S, %d\n"
                                                term inf-ruby-eval-binding
                                                file line))
    (comint-send-region (inf-ruby-proc) start end)
    (comint-send-string (inf-ruby-proc) (concat "\n" "\n"))
    (when print (ruby-print-result))))
