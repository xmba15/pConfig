;;; total-lines-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "total-lines" "total-lines.el" (23317 24626
;;;;;;  73922 182000))
;;; Generated autoloads from total-lines.el

(autoload 'total-lines-mode "total-lines" "\
A minor mode that keeps track of the total number of lines in a buffer.

\(fn &optional ARG)" t nil)

(defvar global-total-lines-mode nil "\
Non-nil if Global Total-Lines mode is enabled.
See the `global-total-lines-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-total-lines-mode'.")

(custom-autoload 'global-total-lines-mode "total-lines" nil)

(autoload 'global-total-lines-mode "total-lines" "\
Toggle Total-Lines mode in all buffers.
With prefix ARG, enable Global Total-Lines mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Total-Lines mode is enabled in all buffers where
`total-lines-on' would do it.
See `total-lines-mode' for more information on Total-Lines mode.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; total-lines-autoloads.el ends here
