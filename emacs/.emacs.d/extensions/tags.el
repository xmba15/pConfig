(message "process tags.el!")

;; ;; semantic-refactoring
(use-package srefactor
  :ensure t
  :init
  (semantic-mode 1)
  (define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  (define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  (global-set-key (kbd "M-RET o") 'srefactor-lisp-one-line)
  (global-set-key (kbd "M-RET m") 'srefactor-lisp-format-sexp)
  (global-set-key (kbd "M-RET d") 'srefactor-lisp-format-defun)
  (global-set-key (kbd "M-RET b") 'srefactor-lisp-format-buffer)
)

;; ;; semantic-mode
(semantic-mode 1)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-add-system-include "/usr/include/boost" 'c++-mode)
(semantic-add-system-include "/opt/izac/include" 'c++-mode)

(use-package ggtags
  :ensure t
  :init
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
                (ggtags-mode 1))))

  ;; (define-key ggtags-mode-map (kbd "C-c g d") 'ggtags-find-definition)
  ;; (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
  ;; (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
  ;; (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
  ;; (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
  ;; (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
  ;; (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
  ;; (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
)

(provide 'tags)
;;; tags.el ends here
