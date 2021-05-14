(provide 'packages)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(use-package bash-completion
  :ensure t
  :init
  (bash-completion-setup)
)

(use-package neotree
  :ensure t
  :bind (("C-c n" . neotree-toggle)
        )
)

(use-package yasnippet
  :ensure t
  :bind (:map yas-minor-mode-map
          ("C-x i i" . yas-insert-snippet)
          ("C-x i n" . yas-new-snippet)
          ("C-x i v" . yas-visit-snippet-file)
        )
  :init
  (yas-global-mode 1)
  (setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        ;; "~/.emacs.d/elpa/yasnippet-snippets-20180503.657/snippets"
        ))
)

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
)

(use-package better-defaults
  :ensure t
)

(use-package popup-imenu
  :ensure t
)

(use-package flx-ido
  :ensure t
  :init
  (ido-mode 1)
  (ido-everywhere 1)
)

(use-package ido-completing-read+
  :ensure t
  :init
  (ido-ubiquitous-mode 1)
)

;; package to show most frequently used commands
(use-package smex
  :ensure t
  :bind (("M-x" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)
        )
)

;; find file in project
(use-package find-file-in-project
  :ensure t
  :bind ("C-c f" . find-file-in-project)
)

;; edit multiple region in code
(use-package iedit
  :ensure t
  :bind (("C-c ;" . iedit-mode)
        )
)

;; flycheck setting
(add-hook 'after-init-hook #'global-flycheck-mode)

;; company setting
(use-package company
  :ensure t
  :init
  (progn (setq company-idle-delay 0)
         (setq company-minimum-prefix-length 2)
         (setq company-selection-wrap-around t)
         (add-hook 'after-init-hook 'global-company-mode)
  )
)

;; add command for avy package
(use-package avy
  :ensure t
  :bind ("C-c c" . avy-goto-char)
)

(use-package ace-window
  :ensure t
  :bind ("C-c a" . ace-window)
)

;; clean-aindent-mode: clean auto-indent and backspace unindent
(use-package clean-aindent-mode
  :ensure t
  :init
  (progn (add-hook 'prog-mode-hook 'clean-aindent-mode)
  )
)

;; dump jump
(use-package dumb-jump
  :ensure t
  :bind (("C-c C-g" . xref-find-definitions)
         ("C-c C-b" . xref-pop-marker-stack)
        )
  :init
  (dumb-jump-mode 1)
)

(use-package expand-region
  :ensure t
  :bind (("C-c e" . er/expand-region)
        )
)

;; yaml mode
(use-package yaml-mode
  :ensure t
  :bind (:map yaml-mode-map
               ("\C-m" . newline-and-indent)
        )
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
  )
)

(use-package markdown-mode
  :ensure t
  :init
  (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
)

;; setting for winner-mode
(use-package winner
  :bind (("C-c C-w <left>" . winner-undo)
         ("C-c C-w <right>" . winner-redo)
        )
  :init
  (winner-mode 1)
)

;; maximize current window (the appearance differs from that when using C-x 1)
(define-key global-map (kbd "C-c C-m") 'maximize-window)

;;; packages.el ends here
