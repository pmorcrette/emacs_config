;; Config for python
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

(provide 'python)
