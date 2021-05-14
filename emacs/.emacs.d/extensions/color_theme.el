;;; color_theme.el --- summary -*- lexical-binding: t -*-

;; Author: xmba15
;; Maintainer: xmba15
;; Version: version
;; Package-Requires: (dependencies)
;; Homepage: homepage
;; Keywords: keywords


;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; commentary

;;; Code:

(message "process color_them.el!")

(provide 'color_theme)

;; (custom-set-variables
;;  '(custom-enabled-themes (quote (deeper-blue))))

;; (load-theme 'sanityinc-tomorrow-eighties t)
(load-theme 'spacemacs-dark t)

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
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'fill)

(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode fci-mode
  (lambda () (if (or (derived-mode-p 'prog-mode) (eq major-mode 'text-mode))
                 (fci-mode 1))))

(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "grey80")
(global-fci-mode t)

;;; color_theme.el ends here
