(message "process java.el!")

(provide 'java)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4
                                  tab-width 4
                                  indent-tabs-mode nil)))

;;; java.el ends here
