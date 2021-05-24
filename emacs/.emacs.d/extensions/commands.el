(message "process commands.el!")

(provide 'commands)

(setq current-commands-file-directory
      (expand-file-name
       (file-name-directory (or load-file-name byte-compile-current-file))))

;; add linum-mode on start-up
(global-set-key (kbd "C-c l") 'linum-mode)
(global-set-key (kbd "M-g l") 'goto-line)

;; comment out region
(defun comment-or-uncomment-line-or-region ()
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    )
  )
(global-set-key (kbd "C-x /") 'comment-or-uncomment-line-or-region)
(global-set-key (kbd "C-x c") 'indent-for-comment)
;; (global-set-key (kbd "C-h") 'delete-backward-char)

;; quick clear screen
(defun my-clear ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun my-shell-hook ()
  (local-set-key "\C-cl" 'my-clear))

(add-hook 'shell-mode-hook 'my-shell-hook)

;; shortcut key to open shell
(global-set-key (kbd "C-c s") 'shell)

(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c t") 'multi-term)

;; go back to previous buffer
(global-set-key (kbd "C-c b") 'mode-line-other-buffer)

;; modify behaviour of window splitting

(defun vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer)
  )
(defun hsplit-last-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer)
  )

(global-set-key (kbd "C-x 2") 'vsplit-last-buffer)
(global-set-key (kbd "C-x 3") 'hsplit-last-buffer)

;; change direction of window splitting
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-c C-t") 'toggle-window-split)

;; set direction of window splitting
(setq split-width-threshold 1 ) ;; horizontal
;; (setq split-width-threshold nil) ;; vertical

;; duplicate thing
(use-package duplicate-thing
  :ensure t
  :bind (("C-c d" . duplicate-thing)
        )
)

(defun sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))
(global-set-key (kbd "M-s e") 'sudo-edit)

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(global-set-key (kbd "C-c [") 'beginning-of-defun)
(global-set-key (kbd "C-c ]") 'end-of-defun)

;; copy one line
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
(global-set-key "\C-c\C-k" 'copy-line)

;; popup-imenu
(use-package popup-imenu
  :ensure t
  :bind (("C-c p" . popup-imenu)
        )
  :init
  ;; Close the popup with same key
  (define-key popup-isearch-keymap (kbd "C-c p") 'popup-isearch-cancel)
)

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))
(global-set-key (kbd "C-c C-r") 'reload-init-file)

;; Navigate to .h och .cpp
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;;Show function name in mod-line--------------
(add-hook 'c-mode-common-hook
  (lambda ()
    (which-function-mode t)))
;;--------------------------------------------

(use-package shell-here
  :ensure t
  :bind (("M-g s" . shell-here)
        )
)

(defun md-table-formatter (start end)
 (interactive "r")
 (setq md-table-formatter (file-truename (concat current-commands-file-directory "../../thirdparty/md-table-formatter.py")))
 (save-excursion
   (shell-command-on-region start end md-table-formatter nil t)))
(global-set-key (kbd "C-x t") 'md-table-formatter)

(provide 'commands)
;;; commands.el ends here
