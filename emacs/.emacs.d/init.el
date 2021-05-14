(message "start init!")

(package-initialize)

(put 'upcase-region 'disabled nil)

(setq-default indent-tabs-mode nil)

(load "~/.emacs.d/extensions/packages.el")
(load "~/.emacs.d/extensions/color_theme.el")
(load "~/.emacs.d/extensions/global.el")
(load "~/.emacs.d/extensions/commands.el")
(load "~/.emacs.d/extensions/java.el")
(load "~/.emacs.d/extensions/python.el")
(load "~/.emacs.d/extensions/c_c++.el")
(load "~/.emacs.d/extensions/tags.el")
(load "~/.emacs.d/extensions/ros.el")
(load "~/.emacs.d/extensions/julia.el")

(provide 'init)
;;; init.el ends here
(put 'downcase-region 'disabled nil)
