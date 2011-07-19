(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(defun dfk (new-key old-key)
  (define-key my-keys-minor-mode-map (read-kbd-macro new-key)  (read-kbd-macro old-key))
 )

(defun dff (new-key old-key)
  (define-key my-keys-minor-mode-map (read-kbd-macro new-key)  old-key)
 )
;; TODO: join line
(dfk "M-8" "C-u 8 C-p")
(dfk "M-u" "C-u 8 C-n")
(dff "M-*" 'beginning-of-buffer)
(dff "M-U" 'end-of-buffer)

(dff "M-i" 'previous-line)
(dff "M-k" 'next-line)
(dff "M-j" 'backward-char)
(dff "M-l" 'forward-char)

(dff "M-SPC" 'set-mark-command)
(dfk "M-x" "C-w")
(dfk "M-c" "M-w")
(dfk "M-v" "C-y")
(dff "M-\\" 'undo)
(dff "M-a" 'mark-whole-buffer)


(dfk "M-u" "C-a")
(dfk "M-o" "C-e")
(dff "M-y" 'kill-buffer)

(dff "M-n" 'ido-switch-buffer)

(dff "M-s" 'save-buffer)

(dff "M-R" 'ido-find-file)
(dff "M-r" 'recentf-ido-find-file)

(dfk "M-9" "C-x o")
(dfk "M-1" "C-x 1")
(dfk "M-2" "C-x 2 C-x o")
(dfk "M-3" "C-x 3 C-x o")
(dfk "M-0" "C-x 0")
(dff "M-4" 'execute-extended-command)
(dff "M-6 M-7" 'save-buffers-kill-terminal)
(dff "M-5" 'eval-buffer)

(dfk "M-," "C-d")
(dfk "M-<RET>" "C-e <RET>")
(dff "M-;"  'whole-line-or-region-comment-dwim)

(dff "M-f" 'isearch-forward-regexp)
(dff "M-F" 'query-replace)

(dff "M-b" 'keyboard-quit) ; doesn't work for some reason

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(defadvice load (after give-my-keybindings-priority)
  "Try to ensure that my keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'my-keys-minor-mode))
      (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist mykeys))))
(ad-activate 'load)

(provide 'my-keys)
