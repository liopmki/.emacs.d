;;; [[Repo init]]
(use-package package
  :config
  ;; Add the NonGNU ELPA package archive
  (require 'package)
  (setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                           ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                           ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
  
  (package-initialize) ;; You might already have this line
  (unless package-archive-contents  (package-refresh-contents))
  )

;;; [[ Basic Setup]]
(use-package emacs
  :config
  ;; Disable splash screen
  (setq inhibit-startup-screen t)

  ;; Clean startup message
  (setq inhibit-startup-message t)

  ;; set unicode encoding
  (prefer-coding-system 'utf-8)

  ;; no lockfile
  (setq create-lockfiles nil)
  
  ;; backup and autosave
  (setq backup-directory-alist `((".*" . ,(expand-file-name "backup" user-emacs-directory))))
  (setq version-control t)
  (setq delete-old-versions t)
  
  ;; initial buffer
  (setq initial-major-mode 'text-mode)
  (setq initial-scratch-message nil)

  ;; no ring bell
  (setq ring-bell-function 'ignore)

  
  ;; nice frame
  ;;(scroll-bar-mode 0)
  ;;(tool-bar-mode 0)
  ;;(menu-bar-mode 0)
  
  ;; nice scrolling
  (pixel-scroll-mode)
  (setq scroll-margin 5)

  ;; Use short answer
  (setq word-wrap-by-category t)

  ;; Word wrap for CJK
  (setq word-wrap-by-category t)

  ;; Enable syntax highlight
  (global-font-lock-mode t)

  ;; indentation
  (setq-default indent-tabs-mode nil)
  (setq-default default-tab-width 4)
  (setq-default c-basic-offset 4)

  ;; Delete selection
  (delete-selection-mode t)

  ;; Auto revert externel changes
  (global-auto-revert-mode t)

  ;; Always load newest byte code
  (setq load-prefer-newer t)

  ;; Highlight current line
  (global-hl-line-mode t)
  
  ;; display time in mode line
  (display-time-mode t)
  (setq display-time-default-load-average nil)
  (setq display-time-24hr-format t)
  (setq system-time-locale "C")

  ;; display battery status
  (display-battery-mode t)

  ;; set frame title
  (setq frame-title-format "%b")

  ;; set a larger kill ring
  (setq kill-ring-max 200)

  ;; use system clipboard
  (setq save-interprogram-paste-before-kill t)

  ;; confirm before quit
  (setq confirm-kill-emacs 'y-or-n-p)

  ;; suppress warnings
  (setq find-file-suppress-same-file-warnings t)
  )

;;; [[Build-in packages]]
(use-package emacs
  :config
  
  ;; abbrev
  (setq save-abbrevs nil)

  ;; dired
  (put 'dired-find-alternate-file 'disabled nil)
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)
  (setq dired-listing-switches "-alh")

  ;; electric [built-in]
  (electric-pair-mode t)
  (electric-indent-mode t)
  (electric-layout-mode t)

  ;; epa [built-in]
  (setq epa-file-cache-passphrase-for-symmetric-encryption t)
  (setq epa-pinentry-mode 'loopback)

  ;; savehist
  (savehist-mode t)

  ;; recentf [built-in]
  (setq recentf-max-saved-items 500)
  (recentf-mode t)

  ;; reftex [built-in]
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-toc-split-windows-horizontally t)

  ;; saveplace [built-in]
  (save-place-mode t)

  ;; tab-bar [built-in]
  (setq tab-bar-show 1)

  ;; tramp [built-in]
  (setq tramp-backup-directory-alist backup-directory-alist)

  ;; use-package [built-in]
  (setq use-package-always-ensure t)

  ;; windmove [built-in]
  (windmove-default-keybindings)

  ;; winner [built-in]
  (winner-mode t)

  ;; zone [built-in]
  (autoload 'zone-when-idle "zone" nil t)
  (zone-when-idle 18000)

  :hook
  
  ;; display-line-numbers
  (prog-mode . display-line-numbers-mode)

  ;; hideshow
  (prog-mode . hs-minor-mode)
  
  )

;;; [[ Theme ]]

;; doom-themes
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-dracula t))

;; doom mode line
(use-package doom-modeline
  :hook(after-init . doom-modeline-mode))

;; nerd-icons
(use-package nerd-icons)

;;; [[ Completion Framework ]]

;; vertico + orderless + marginalia + consult
(use-package vertico
  :ensure t
  :init(vertico-mode)
  :custom
  (vertico-resize t)
  (vertico-cycle t)
  :config
  (use-package orderless
    :ensure t
    :custom (completion-styles '(substring orderless)))
  (use-package marginalia
    :ensure t
    :init (marginalia-mode)
    :custom (marginalia-annotator-registry
             '((command marginalia-annotate-binding builtin none))))
  (use-package consult
    :ensure t
    :custom (consult-preview-key "M-.")
    :bind (("C-x b" . consult-buffer)
           ("C-s" . consult-line)
           ("M-y" . consult-yank-pop)
           ("C-c i" . consult-imenu))))

;; corfu + cape
(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (corfu-on-exact-match nil)
  (corfu-preview-current nil)
  :config (global-corfu-mode)
  (use-package cape
    :ensure t
    :config
    (add-to-list 'completion-at-point-functions #'cape-abbrev)
    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-keyword)))

;;; [[ LSP Support ]]
(use-package eglot
  :custom
  (eglot-autoshutdown t)
  :hook(prog-mode . eglot-ensure))


;;; [[ Spell ]]
;; flymake
;; (use-package flymake
;;   :ensure t
;;   :bind
;;   (("M-n" 'flymake-goto-next-error)
;;   ("M-p" 'flymake-goto-prev-error))
;;   :hook(prog-mode . flymake-mode))

;; flycheck
(use-package flycheck
  :init(global-flycheck-mode))

;;; [[ Treesit ]]
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;;; [[ Which key ]]
(use-package which-key
  :ensure t
  :config(which-key-mode))

;; [[Custom File]]
;; Store automatic customisation options elsewhere
(use-package emacs
  :config
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file)))

