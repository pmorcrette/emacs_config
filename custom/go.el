(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package go-mode
  :ensure t
  :hook
  (go-mode . lsp-deferred)
  (go-mode . lsp-go-install-save-hooks))

(provide 'go)
