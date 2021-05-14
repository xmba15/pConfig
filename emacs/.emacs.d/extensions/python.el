;;; python.el --- summary -*- lexical-binding: t -*-

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

(message "process python.el!")

(provide 'python)

(require 'jedi-core)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
(add-hook 'python-mode-hook 'jedi:setup)
;; (add-to-list 'company-backends 'company-jedi)

(defun non-company-mode-hook ()
  (company-mode -1)
)
(add-hook 'jedi-mode-hook 'non-company-mode-hook)

(require 'py-autopep8)
(setq py-autopep8-options '("--max-line-length=120"))
(setq flycheck-flake8-maximum-line-length 120)
(add-hook 'jedi-mode-hook 'py-autopep8-enable-on-save)

(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;;; python.el ends here
