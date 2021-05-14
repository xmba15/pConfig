(message "process python.el!")

(provide 'python)

;; (use-package jedi-core
;;   :ensure t
;;   :init
;;   (setq jedi:complete-on-dot t)
;;   (setq jedi:use-shortcuts t)
;;   (add-hook 'python-mode-hook 'jedi:setup)
;;   ;; (add-to-list 'company-backends 'company-jedi)

;;   (defun non-company-mode-hook ()
;;     (company-mode -1)
;;     )
;;   (add-hook 'jedi-mode-hook 'non-company-mode-hook)
;; )

(use-package py-autopep8
  :ensure t
  :init
  (setq py-autopep8-options '("--max-line-length=120"))
  (add-hook 'jedi-mode-hook 'py-autopep8-enable-on-save)
)

(setq flycheck-flake8-maximum-line-length 120)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;;; python.el ends here
