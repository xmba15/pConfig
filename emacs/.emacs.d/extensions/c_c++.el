(message "process c_c++.el!")

(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))

;; template ipp file as cpp mode
(add-to-list 'auto-mode-alist '("\\.ipp$" . c++-mode))

;; indent for openmp
(c-set-offset (quote cpp-macro) 0 nil)

;; (use-package flymake-google-cpplint
;;   :ensure t
;;   :init
;;   (defun my:flymake-google-init ()
;;     (require 'flymake-google-cpplint)
;;     (custom-set-variables
;;      '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
;;     (flymake-google-cpplint-load)
;;   )
;;   (add-hook 'c-mode-hook 'my:flymake-google-init)
;;   (add-hook 'c++-mode-hook 'my:flymake-google-init)
;; )

;; add flymake-cursor-mode
(eval-after-load 'flymake '(require 'flymake-cursor))

(use-package google-c-style
  :ensure t
  :init
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
)

;; install clang-dev with the following command in ubuntu
;; sudo apt-get install libclang-dev
(use-package irony
  :ensure t
  :init
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-irony))

)
(add-to-list 'company-backends 'company-c-headers)

(setq company-c-headers-path-system '(
                                      "/usr/include/c++/5"
                                      "/usr/include"
                                      "/usr/local/include"
                                      "/usr/include/eigen3"
                                      "/usr/local/include/eigen3"
                                      ))

(add-hook 'c-mode-hook 'electric-pair-mode)
(add-hook 'c++-mode-hook 'electric-pair-mode)
(add-hook 'objc-mode-hook 'electric-pair-mode)

;; When executing irony-install-server,
;;  you need to add a flag
;; -DCMAKE_PREFIX_PATH=/usr/local/opt/llvm
;;  after cmake to specify where the llvm is. Finally everything is ok.

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; set clang-format
;; install clang-format and make a symbolic link in /usr/bin/
(use-package clang-format
  :ensure t
  :bind (("C-c i" . clang-format-region)
         ("C-c u" . clang-format-buffer)
        )
  :init
  (setq clang-format-style-option "llvm")
)

(provide 'c_c++)
;;; c_c++.el ends here
