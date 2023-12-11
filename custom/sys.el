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

(provide 'sys)
