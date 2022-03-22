

;; (require 'jsonrpc)
;(setq lsp-dart-flutter-widget-guides nil)
;(setq lsp-dart-outline nil)
;(setq lsp-dart-flutter-outline nil)
;(setq lsp-semantic-tokens-enable nil)
;(setq lsp-enable-symbol-highlighting nil)
;(setq lsp-headerline-breadcrumb-enable nil)
;(add-hook 'dart-mode-hook))

(setq dart-sdk-dir "/home/como/snap/flutter/common/flutter/bin/cache/dart-sdk")
(setq dart-flutter-sdk-dir "/home/como/snap/flutter/common/flutter")

(use-package eglot
  :init (progn
	  ))

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)
(add-hook 'go-mode-hook 'eglot-ensure)

(setq-default eglot-workspace-configuration
    '((:gopls .
        ((staticcheck . t)
         (matcher . "CaseSensitive")))))
;; (defun flutter-project-external-roots ()
;;   (setq-local project-vc-external-roots-function (lambda ()
;; 						   flutter-library-dir)))
(defvar dart-bin
  (concat dart-sdk-dir "/bin/dart"))

(defvar analysis-server
  (concat dart-sdk-dir "/bin/snapshots/analysis_server.dart.snapshot"))

;; (defvar con
;;   (jsonrpc-process-connection :process (get-process "sh24")))

;; (jsonrpc-async-request
;;  con :initialize params
;;  :success-fn (lambda (m)
;; 	       (message "Server replied back with %s!" m))
;;  :error-fn (jsonrpc-lambda (&key code message _data)
;; 	     (message "Sadly, server reports %s: %s"
;; 		      code message)))

;; (make-process
;;  :name "sh24"
;;  :noquery t
;;  :coding 'utf-8-emacs-unix
;;  :connection-type 'pipe
;;  :file-handler t
;;  :command `(,dart-bin ,analysis-server "--lsp"))

;; (advice-add 'save-some-buffers :after #'save-and-hot-reload)

;; (defun save-and-hot-reload (a)
;;   (if (derived-mode-p 'dart-mode)
;;       (flutter-hot-reload)))




(with-eval-after-load 'dart-mode
  (define-key dart-mode-map (kbd "d") 'save-all-and-reload)
  (define-key dart-mode-map (kbd "D") 'save-all-and-restart)
  (define-key dart-mode-map (kbd "C-\\") 'flutter-open-log))

(defun x-eglot-prepare ()
  (eldoc-mode -1)
  (flymake-mode -1)
  (remove-hook 'before-save-hook 'eglot--signal-textDocument/willSave t)
  (remove-hook 'after-save-hook 'eglot--signal-textDocument/didSave t))

(defun flutter-start ()
  (interactive)
  (flutter-run "-d linux --no-sound-null-safety --enable-experiment=nonfunction-type-aliases"))

(defun flutter-reload ()
  (interactive)
  (save-buffer)
  (flutter-hot-restart))

(defun flutter-reload-and-open-buf ()
  (interactive)
  (save-buffer)
  (display-buffer "*Flutter*")
  (flutter-hot-reload))

(defun flutter-open-log ()
  (interactive)
  ;; (delete-window (display-buffer "*Flutter*"))
  (display-buffer "*Flutter*"))

(defun save-all-and-reload ()
  (interactive)
  (save-some-buffers t)
  (flutter-hot-reload))

(defun save-all-and-restart ()
  (interactive)
  (save-some-buffers t)
  (flutter-hot-restart))

(add-hook 'eglot--managed-mode-hook 'x-eglot-prepare)
;; (add-hook 'dart-mode-hook 'set-keys)
