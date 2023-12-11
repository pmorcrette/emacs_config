(add-to-list 'load-path "~/.emacs.d/custom/")
(require 'main)
(use-package doom-themes
  :init
  (load-theme 'doom-one t))
