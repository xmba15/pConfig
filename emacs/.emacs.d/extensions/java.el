;;; java.el --- summary -*- lexical-binding: t -*-

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

(message "process java.el!")

(provide 'java)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4
                                  tab-width 4
                                  indent-tabs-mode nil)))

;;; java.el ends here
