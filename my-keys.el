(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(defun dfk (new-key old-key)
  (define-key my-keys-minor-mode-map (read-kbd-macro new-key)  (read-kbd-macro old-key))
 )

(defun dff (new-key old-key)
  (define-key my-keys-minor-mode-map (read-kbd-macro new-key)  old-key)
 )

(dfk "M-I" "C-u 8 C-p")
(dfk "M-K" "C-u 8 C-n")
(dff "M-J" 'backward-word)
(dff "M-L" 'forward-word)

(dff "M-i" 'previous-line)
(dff "M-k" 'next-line)
(dff "M-j" 'backward-char)
(dff "M-l" 'forward-char)

(dff "M-SPC" 'set-mark-command)
(dfk "M-x" "C-w")
(dfk "M-c" "M-w")
(dfk "M-v" "C-y")
(dff "M-u" 'undo)
(dff "M-a" 'mark-whole-buffer)

(dff "M-h" 'scroll-down)
(dff "M-b" 'scroll-up)
(dff "M-H" 'beginning-of-buffer)
(dff "M-B" 'end-of-buffer)

(dfk "M-n" "C-a")
(dfk "M-m" "C-e")
(dff "M-y" 'kill-buffer)

(dff "M-t" 'bs-cycle-previous)

(dff "M-s" 'save-buffer)
(dff "M-4" 'execute-extended-command)
(dff "M-7" 'keyboard-quit) ; doesn't work for some reason
(dff "M-6 M-7" 'save-buffers-kill-terminal)

(dff "M-o" 'ido-find-file)
(dff "M-r" 'recentf-ido-find-file)
 
(dfk "M-9" "C-x o")
(dfk "M-1" "C-x 1") 
(dfk "M-2" "C-x 2 C-x o")
(dfk "M-3" "C-x 3 C-x o")
(dfk "M-0" "C-x 0")

(dfk "M-," "C-d")
(dfk "M-<RET>" "C-e <RET>")
(dff "M-;"  'whole-line-or-region-comment-dwim)

(dff "M-f" 'isearch-forward-regexp)
(dff "M-F" 'query-replace)


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
