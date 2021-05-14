(message "process color_them.el!")

(provide 'color_theme)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (load-theme 'sanityinc-tomorrow-eighties t)
)

(require 'whitespace)
(setq whitespace-style '(face trailing tabs empty space-mark tab-mark newline-mark))
(setq whitespace-display-mappings
      '(
        (space-mark   ?\     [? ]) ;; use space not dot
        (space-mark   ?\xA0  [?\u00A4]     [?_])
        (space-mark   ?\x8A0 [?\x8A4]      [?_])
        (space-mark   ?\x920 [?\x924]      [?_])
        (space-mark   ?\xE20 [?\xE24]      [?_])
        (space-mark   ?\xF20 [?\xF24]      [?_])
        (newline-mark ?\n    [?\u21B5 ?\n] [?$ ?\n])	; eol - downwards arrow
        (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t])
))

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :background my/bg-color
                    :foreground "LightSkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :background my/bg-color
                    :foreground "GreenYellow"
                    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
                    :background my/bg-color)

(global-whitespace-mode 1)
(global-hl-line-mode t)
(set-face-background 'hl-line "color-255")
(set-face-foreground 'hl-line "color-160")
(set-face-bold 'hl-line t)

(require 'linum)
(set-face-foreground 'linum "color-161")

;; Highlights parentheses, brackets, and braces according to their depth.
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
)

(use-package highlight-indent-guides
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'fill)
)

(use-package fill-column-indicator
  :ensure t
  :init
  (define-globalized-minor-mode global-fci-mode fci-mode
    (lambda () (if (or (derived-mode-p 'prog-mode) (eq major-mode 'text-mode))
                   (fci-mode 1))))
  (setq fci-rule-column 80)
  (setq fci-rule-width 1)
  (setq fci-rule-color "grey80")
  (global-fci-mode t)
)

;;; color_theme.el ends here
