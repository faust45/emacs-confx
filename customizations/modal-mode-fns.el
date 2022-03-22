;;; -*- lexical-binding: t; -*

(require 'dash)

(defun dired-default ()
  (interactive)
  (dired ""))

(defun disable-modal-and-common-modes ()	
  (interactive)
  (modal-mode -1))

(defun yank-and-indent ()
  (interactive)
  (save-excursion
    (yank)
    (indent-region (line-beginning-position) (line-end-position))))

(defun replace-char ()
  (interactive)
  (let ((ch (read-char)))
    (delete-char 1)
    (insert ch)
    (backward-char)))

(defun x-insert-char ()
  (interactive)
  (let ((ch (read-char)))
    (insert ch)
    (backward-char)))

(defun modal-take (ch)
  (interactive "c")
  (set-mark (point))
  (let ((f (or (lookup-key movements-map (vector ch))
	       (lookup-key mark-map (vector ch)))))
    (funcall f)
    (kill-region (region-beginning) (region-end))))

(defun modal-copy (ch)
  (interactive "c")
  (let ((pos (point))
	(f (or (lookup-key movements-map (vector ch))
	       (lookup-key mark-map (vector ch)))))
    (funcall f)
    (kill-ring-save (region-beginning) (region-end))
    (goto-char pos)))

(defun concat-sym (&rest a)
  (intern (mapconcat 'symbol-name a "")))

(dolist (el '(next-line))
  (eval
   `(defun ,(concat-sym 'm-cmd-el) ()
      (interactive)
      (,el)
      (message "mama data"))))

(defun modal-switch-to-insert ()
  (interactive)
  (modal-mode -1)
  (insert-mode +1))

(defun mark-line ()
  (interactive)
  (set-mark (line-beginning-position))
  (end-of-line)
  (forward-char))

(defun switch-insert-to-modal ()
  (interactive)
  (insert-mode -1)
  (modal-mode +1))

(defun switch-to-modal ()
  (interactive)
  (message "DEBUG quit")
  (insert-mode -1)
  (modal-mode +1))

(defun switch-modal-to-insert ()
  (interactive)
  (insert-mode +1)
  (modal-mode -1))

(defun insert-single-quote ()
  (interactive)
  (insert "'"))

(defun insert-quotes ()
  (interactive)
  (insert "\"\"")
  (backward-char 1)
  (if modal-mode
      (switch-modal-to-insert)))

(defun insert-newline-up ()
  (interactive)
  (previous-line)
  (end-of-line)
  (newline-and-indent))

(defun insert-newline-down ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun yank-down-line ()
  (interactive)
  (save-excursion
    (insert-newline-down)
    (let ((s
	   (->> kill-ring
	     car
	     substring-no-properties
	     (replace-regexp-in-string "\n$" ""))))
      (insert s))
    (call-interactively 'indent-region)))

(defun yank-up-line ()
  (interactive)
  (save-excursion
    (insert-newline-up)
    (let ((s
	   (->> kill-ring
	     car
	     substring-no-properties
	     (replace-regexp-in-string "\n$" ""))))
      (insert s))
    (call-interactively 'indent-region)))

(defun cmd-ignore ()
  (interactive))

(defun x-join-line ()
  (interactive)
  (save-excursion
    (forward-line)
    (join-line)
    (delete-horizontal-space)))

(defun switch-buff ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun scroll-half-page-down ()
  "scroll down half the page"
  (interactive)
  (scroll-down (/ (window-body-height) 2)))

(defun scroll-half-page-up ()
  "scroll up half the page"
  (scroll-up (/ (window-body-height) 2)))

(defun copy-symbol ()
  (interactive)
  (kill-new (thing-at-point 'symbol)))

(defun replace-at-point ()
  (interactive)
  (let*
      ((bounds
	(if (use-region-p)
	    (cons (region-beginning) (region-end))
	    (bounds-of-thing-at-point 'symbol))))
    (delete-region (car bounds) (cdr bounds))
    (yank-and-indent)))

;; works only for single child parent widget
(defun flutter-replace-parent-widget-with-child ()
  (interactive)
  (er/expand-region +2)
  (kill-region (region-beginning) (region-end))
  (er/expand-region +2)
  (replace-at-point)
  (er/expand-region +2)
  (indent-region (region-beginning) (region-end)))

(defun upper-case-next-char (ch)
  (interactive "c")
  (insert (upcase ch)))

(defun upper-case-last-char ()
  (interactive)
  (save-excursion
    (capitalize-region (- (point) 1) (point))))

(defun insert-brackets (s)
  (insert s)
  (backward-char)
  (modal-switch-to-insert))

(defun insert-brackets-b ()
  (interactive)
  (insert-brackets "()"))

(defun insert-brackets-a ()
  (interactive)
  (insert-brackets "[]"))

(defun save-all ()
  (interactive)
  (save-some-buffers t))

(defun x-abbr-expand ()
  (interactive)
  (er/mark-word)
  (let (s (thing-at-point 'symbol))
    ))

(defun x-abbr-expand-wrap-region (ch)
  (interactive "cApply abbr...")
  (let* ((pos (point))
	 (s (buffer-substring (mark) (point)))
	 (abbr (lookup-key abbr-map (vector ch)))
	 (a (replace-regexp-in-string "\\$" s abbr)))
    (delete-region (mark) (point))
    (insert a)
    (er/expand-region +1)
    (indent-region (point) (mark))
    (goto-char pos)))

(provide 'modal-mode-fns)
