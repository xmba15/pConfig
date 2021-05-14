(message "process julia.el!")

(provide 'julia)

(setq current-julia-file-directory
      (expand-file-name
       (file-name-directory (or load-file-name byte-compile-current-file))))

(use-package julia-mode
  :ensure t
)

(use-package julia-repl
  :ensure t
  :hook (julia-mode . julia-repl-mode)
)

;;; julia.el ends here
