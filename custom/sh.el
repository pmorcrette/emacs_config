(use-package flymake)
(use-package sh-script
  :hook (sh-mode . flymake-mode))

(provide 'sh)
