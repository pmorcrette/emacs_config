;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

;; setup MELPA
(require 'package)
(setq package-archives
'(("melpa" . "https://melpa.org/packages/")
("elpa" . "https://elpa.gnu.org/packages/")
("nongnu" . "https://elpa.nongnu.org/nongnu/")))


(require 'use-package)
(setq use-package-always-ensure t)

(setq native-comp-deferred-compilation-deny-list nil)
;; Install straight.el
(defvar bootstrap-version)
(let
    ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
     (bootstrap-version 5))
  (unless
      (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char
       (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; Remove some stuff from UI & Startup
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(display-battery-mode 1)
(menu-bar-mode -1)
(setq visible-bell t)
(setq inhibit-startup-message -1)
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8-unix)

  ;;change font
(use-package all-the-icons
      :if
(display-graphic-p))
(use-package all-the-icons-dired
      :after all-the-icons
      :hook
(dired-mode . all-the-icons-dired-mode))

(setq display-time-string-forms
'((propertize
(concat " " 24-hours ":" minutes " ")
'face 'egoge-display-time)))
(display-time-mode 1)
(setq display-time-default-load-average nil)

(fset 'yes-or-no-p 'y-or-n-p)
(setq native-comp-async-report-warnings-errors 'silent)

(use-package general)


(use-package marginalia
        :general
(:keymaps 'minibuffer-local-map
         "M-A" 'marginalia-cycle)
:custom
(marginalia-max-relative-age 0)
(marginalia-align 'right)
:init
(marginalia-mode)
:config
(all-the-icons-completion-marginalia-setup))

(use-package all-the-icons-completion
  :after
  (marginalia all-the-icons))

(use-package vertico
  :config
(vertico-reverse-mode)
:init
(vertico-mode))


(use-package corfu
  :straight
  (corfu :files
         (:defaults "extensions/*")
         :includes
         (corfu-info corfu-history corfu-popupinfo))
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-separator ?\s)
  (corfu-popupinfo-delay 0)
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :general
  (:keymaps 'corfu-map
            "SPC" 'corfu-insert-separator))


(use-package consult       
    :hook
(completion-list-mode . consult-preview-at-point-mode)
:init
(setq register-preview-delay 0.5
          register-preview-function #'consult-register-format)
(advice-add #'register-preview :override #'consult-register-window)
(setq xref-show-xrefs-function #'consult-xref
          xref-show-definitions-function #'consult-xref)
:config
(consult-customize
     consult-theme :preview-key
'(:debounce 0.2 any)
consult-ripgrep consult-git-grep consult-grep
     consult-bookmark consult-recent-file consult-xref
     consult--source-bookmark consult--source-file-register
     consult--source-recent-file consult--source-project-recent-file
     :preview-key
'(:debounce 0.4 any))
(setq consult-narrow-key "<")
:general
("M-y" #'consult-yank-from-kill-ring)
("C-x b" #'consult-buffer)
("C-x C-/" #'consult-find)
("C-x M-/" #'consult-grep))



(use-package kind-icon
  :ensure t
  :after corfu
  :custom
(kind-icon-default-face 'corfu-default)
; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package which-key
  :init
(which-key-mode)
:diminish which-key-mode)

(use-package magit)
(use-package forge
  :after magit)


  ;; Some useful editor config
(column-number-mode)
(global-display-line-numbers-mode t)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none)
  ;; we use Corfu!
  :init
  (defun my/lsp-mode-setup-completion
      ()
    (setf
     (alist-get 'styles
                (alist-get 'lsp-capf completion-category-defaults))
     '(orderless)))
  ;; Configure orderless
  (advice-add 'lsp :before #'direnv-update-environment)
  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion)
  (lsp-mode .
            (lambda
              ()
              (let
                  ((lsp-keymap-prefix "C-c l"))
                (lsp-enable-which-key-integration))))
  :config
  (lsp-enable-which-key-integration t)
  (define-key lsp-mode-map
              (kbd "C-c l")
              lsp-command-map))
(use-package lsp-ui
  :hook
  (lsp-mode . lsp-ui-mode))

;; IDE for python
(use-package python-mode
  :ensure t
  :hook
  (python-mode . lsp-deferred))
(use-package lsp-pyright
  :ensure t
  :hook
  (python-mode .
	       (lambda ()
		 (require 'lsp-pyright)
		 (lsp-deferred)))) ; or lsp-deferred

(use-package yaml-mode)

(use-package highlight-indentation)

(add-hook 'yaml-mode-hook
	  (lambda ()
	    (define-key yaml-mode-map "\C-m" 'newline-and-indent)
	    (highlight-indentation-mode)))

(use-package eshell-git-prompt)
(use-package eshell
  :config
  (eshell-git-prompt-use-theme 'multiline2)
  (setq eshell-history-size         10000
	eshell-buffer-maximum-lines 10000
	eshell-hist-ignoredups t
	eshell-scroll-to-bottom-on-input t))

(defalias 'ff 'find-file-other-window)

(defun esh(name)
  (interactive "sName: ")
  (eshell 'N)
  (if (not (= (length name) 0))
      (rename-buffer name)))

(use-package orderless
  :init
  (setq completion-styles
	'(orderless partial-completion basic)
	completion-category-defaults nil
	completion-category-overrides nil))

(use-package doom-themes
  :init
  (load-theme 'doom-one t))
