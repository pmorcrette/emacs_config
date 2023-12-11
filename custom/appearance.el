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



(setq display-time-string-forms
'((propertize
(concat " " 24-hours ":" minutes " ")
'face 'egoge-display-time)))
(display-time-mode 1)
(setq display-time-default-load-average nil)

(fset 'yes-or-no-p 'y-or-n-p)
(setq native-comp-async-report-warnings-errors 'silent)

(provide 'appearance)
