;;; -*- lexical-binding: t; -*

(require 'dash)
(require 'modal-mode-fns)
(require 'expand-region)

(provide 'modal-mode)

(setq display-buffer-alist
      '(("*Flutter"
	 display-buffer-in-side-window
	 (side . bottom)
	 (slot . -1)
	 (window-height . 7)
	 (window-parameters . ((no-other-window . t))))
	("*Help*\\|*Flymake*"
	display-buffer-use-some-window
        (inhibit-same-window . t))))

(winner-mode 1)
;(one-window-p)

(defvar utils-map
  '(
    (?d . save-all)
    (?s . isearch-forward-symbol-at-point)
    (?\C-\: . project-find-file)))

(defvar movements-map
  '(
    (?\k . beginning-of-buffer)
    (?\. . end-of-buffer)
    (?\, . scroll-down-line)
    (?\h . scroll-up-line)

    (?e . next-line)
    (?i . previous-line)
    (?u . backward-word)
    (?y . forward-word)
    (?o . forward-char)
    (?n . backward-char)
    (?l . back-to-indentation)
    (?\: . end-of-line)))

(defvar mark-map
  '(
    (?r . er/mark-inside-pairs)
    (?a . er/mark-outside-pairs)
    (?e . er/mark-method-call)
    (?s . er/mark-symbol)
    (?d . mark-line)))

(defvar foo `(a b c))

(defvar common-keys-mode-map
  `(
    (?\C-o . newline-and-indent)
     (?\C-0 . winner-undo)
     (?\C-9 . winner-redo)))


(defvar modal-mode-map
  `(keymap
    ,@movements-map
    (?d . modal-take)
    (?\  . modal-copy)

    (?\C-d . dired-default)
    (?t . switch-modal-to-insert)
    (?3 . insert-quotes)
    (?\C-? . ignore)
    
    ;; (?\C-m . winner-undo)

    (tab . other-window)
    (?f . copy-symbol)
    (?\\ . split-window-right)
    
    (?r . replace-char)
    (?w . x-insert-char)

    (?\C-b . x-abbr-expand-wrap-region)
    (?\C-p . x-join-line)
    
    (?\C-l . yank-and-indent)
    (?\C-u . yank-down-line)
    (?\C-y . yank-up-line)
    (?\C-j . replace-at-point)
    ,@utils-map
    ,@common-keys-mode-map
    
    (remap keymap (self-insert-command . ignore))
    (,meta-prefix-char keymap
		       (?u . insert-newline-down)
		       (?y . insert-newline-up))
    
    (?\C-e . switch-to-buffer)
    (?\C-i . switch-buff)

    (?q . set-mark-command)))

(defvar insert-mode-map
  `(keymap
    (,meta-prefix-char keymap ,@movements-map)

    (?\C-m . upper-case-next-char)
    (?\; . upper-case-next-char)
    (?9 . insert-brackets-b)
    (?\[ . insert-brackets-a)
    (?\C-\: . insert-brackets-c)
    (?\C-l . yank-and-indent)
    (?2 . insert-single-quote)
    (?3 . insert-quotes)
    (?\C-t . switch-insert-to-modal)
    ,@common-keys-mode-map))


(define-minor-mode insert-mode
  "Insert mode"
  :lighter " I"
  :keymap insert-mode-map
  (if insert-mode
      (setq cursor-type 'bar)))

(define-minor-mode modal-mode
  "Modal mode"
  :lighter " M"
  ;;:global nil 
  :keymap modal-mode-map
  (if modal-mode
      (setq cursor-type 'box)))

(advice-add 'keyboard-quit :before 'switch-to-modal)


