;;; tags.el --- summary -*- lexical-binding: t -*-

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

(message "process tags.el!")

;; ;; semantic-refactoring
(semantic-mode 1)
(require 'srefactor)
(require 'srefactor-lisp)
(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(global-set-key (kbd "M-RET o") 'srefactor-lisp-one-line)
(global-set-key (kbd "M-RET m") 'srefactor-lisp-format-sexp)
(global-set-key (kbd "M-RET d") 'srefactor-lisp-format-defun)
(global-set-key (kbd "M-RET b") 'srefactor-lisp-format-buffer)

;; ;; semantic-mode
(semantic-mode 1)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-add-system-include "/usr/include/boost" 'c++-mode)
(semantic-add-system-include "/opt/izac/include" 'c++-mode)

(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g d") 'ggtags-find-definition)
(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(setq-local imenu-create-index-function #'ggtags-build-imenu-index)

(provide 'tags)
;;; tags.el ends here
