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

(require 'appearance)
(require 'behaviour)
(require 'sys)
(require 'IDE)
(provide 'main)
