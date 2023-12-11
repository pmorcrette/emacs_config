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

(require 'python)
(require 'yaml)
(provide 'IDE)
