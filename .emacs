;; layout
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(delete-selection-mode 1)

;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    flycheck company avy which-key helm-xref dap-mode helm-ls-git magit))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;;
(require 'helm-ls-git)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "C-c g") 'helm-grep-do-git-grep)

(require 'magit)
(global-set-key [f12] 'magit-status)

;; compilation
(savehist-mode 1)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(global-set-key [f9] 'compile)
(setq compilation-always-kill t)
(setq compilation-scroll-output 'first-error)

;; indent style
(setq-default indent-tabs-mode nil)
(setq c-default-style "bsd"
      c-basic-offset 4)
(defun my-indent-setup ()
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-indent-setup)

(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

;; backup files
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))
(setq backup-by-copying t)
