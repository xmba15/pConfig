(message "process global.el!")

(provide 'global)

(setq current-global-file-directory
      (expand-file-name
       (file-name-directory (or load-file-name byte-compile-current-file))))

;; start up with empty scratch
(setq inhibit-startup-screen +1)
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message nil)
(toggle-frame-maximized)

;; show time
;; (setq display-time-24hr-format t)
;; (display-time-mode 1)

(add-to-list 'auto-mode-alist '(".bash_aliases" . shell-script-mode))

;; 日本語環境
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))
(put 'erase-buffer 'disabled nil)

;; set up for mode line
(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/active-background-color "gray60")
  ;; show column number for mode line
  (column-number-mode 1)
  ;; show line number for mode line
  (line-number-mode t)

  (setq sml/name-width 20)
  (setq sml/mode-width 'full)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t)

  (setq sml/no-confirm-load-theme t)
  (sml/setup)
  (sml/apply-theme 'dark)

  (add-hook 'after-save-hook
            (lambda ()
              (let ((orig-fg (face-background 'mode-line)))
                (set-face-background 'mode-line "dark green")
                (run-with-idle-timer 0.1 nil
                                     (lambda (fg) (set-face-background 'mode-line fg))
                                     orig-fg))))
)

;; show total lines of current files
(use-package total-lines
  :ensure t
  :init
  (global-total-lines-mode t)
  (defun my-set-line-numbers ()
    (setq-default mode-line-front-space
                  (append mode-line-front-space
                          '((:eval (format " (%d)" (- total-lines 1)))))))
  (add-hook 'after-init-hook 'my-set-line-numbers)
)

;; ivy package
(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
)

(use-package swiper
  :ensure t
  :after ivy
  :init
  (global-set-key (kbd "C-s") 'swiper)
)

(use-package counsel
  :ensure t
  :after ivy
  :init
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

  (global-set-key (kbd "C-c h") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
)

;; open new shell in the same window
(push (cons "\\*shell\\*" display-buffer--same-window-action) display-buffer-alist)

(use-package multi-term
  :ensure t
  :init
  (setq multi-term-program "/bin/bash")
)

;; beacon
(use-package beacon
  :ensure t
  :init
  (beacon-mode 1)
)

(use-package xclip
  :ensure t
  :init
  (condition-case nil
      (progn
        (require 'xclip)
        (xclip-mode 1) )
    (file-error (message "xclip has not been installed. Please install xclip"))
  )
)

;; add space around operators automatically
(use-package electric-operator
  :ensure t
  :init
  (add-hook 'c++-mode-hook #'electric-operator-mode)
  (add-hook 'c-mode-hook #'electric-operator-mode)
  (add-hook 'python-mode-hook #'electric-operator-mode)
)

;; pair () automatically
(electric-pair-mode t)
(setq electric-pair-preserve-balance nil)

;; plantuml-mode setting
(use-package plantuml-mode
  :ensure t
  :init
  (setq plantuml-jar-path (file-truename (concat current-global-file-directory "../../thirdparty/plantuml.jar")))
  (add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
)

(use-package restart-emacs
  :ensure t
)

;; clear buffer history
(setq ido-virtual-buffers '())
(setq recentf-list '())

;;; global.el ends here
