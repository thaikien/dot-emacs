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
    projectile hydra flycheck company avy which-key helm-xref dap-mode helm-ls-git magit))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;;
(require 'helm-ls-git)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "C-c g") 'helm-grep-do-git-grep)

(require 'magit)
(global-set-key [f12] 'magit-status)

;; compilation
(setq compile-command "ninja")
(global-set-key [f9] 'compile)
(setq compilation-always-kill t)
(setq compilation-scroll-output 'first-error)

;; indent style
(setq-default indent-tabs-mode nil)
(setq c-default-style "bsd"
      c-basic-offset 2)
(defun my-indent-setup ()
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-indent-setup)

;; backup files
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))
(setq backup-by-copying t)
