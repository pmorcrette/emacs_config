(use-package flymake)
(use-package sh-script
  :hook (sh-mode . flymake-mode))
(use-package shfmt
  :hook
  (sh-mode . shfmt-on-save-mode))
(provide 'sh)
