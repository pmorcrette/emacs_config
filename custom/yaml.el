(use-package yaml-mode)

(use-package highlight-indentation)

(add-hook 'yaml-mode-hook
	  (lambda ()
	    (define-key yaml-mode-map "\C-m" 'newline-and-indent)
	    (highlight-indentation-mode)))

(provide 'yaml)
