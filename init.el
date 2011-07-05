(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "M-I")  'previous-logical-line)
(define-key my-keys-minor-mode-map (kbd "M-K")  'next-logical-line)
(define-key my-keys-minor-mode-map (kbd "M-J")  'backward-word)
(define-key my-keys-minor-mode-map (kbd "M-L")  'forward-word)

(define-key my-keys-minor-mode-map (kbd "M-i")  'previous-line)
(define-key my-keys-minor-mode-map (kbd "M-k")  'next-line)
(define-key my-keys-minor-mode-map (kbd "M-j")  'backward-char)
(define-key my-keys-minor-mode-map (kbd "M-l")  'forward-char)

(define-key my-keys-minor-mode-map (kbd "M-SPC") 'set-mark-command)
(define-key my-keys-minor-mode-map (kbd "M-x")  (kbd "C-w"))
(define-key my-keys-minor-mode-map (kbd "M-c")  (kbd "M-w"))
(define-key my-keys-minor-mode-map (kbd "M-v")  (kbd "C-y"))
(define-key my-keys-minor-mode-map (kbd "M-u")  'undo)
(define-key my-keys-minor-mode-map (kbd "M-a")  'mark-whole-buffer)

(define-key my-keys-minor-mode-map (kbd "M-h")  'scroll-down)
(define-key my-keys-minor-mode-map (kbd "M-b")  'scroll-up)
(define-key my-keys-minor-mode-map (kbd "M-H")  'beginning-of-buffer)
(define-key my-keys-minor-mode-map (kbd "M-B")  'end-of-buffer)

(define-key my-keys-minor-mode-map (kbd "M-n")  (kbd "C-a"))
(define-key my-keys-minor-mode-map (kbd "M-m")  (kbd "C-e"))
(define-key my-keys-minor-mode-map (kbd "M-y")  (kbd "C-k"))
(define-key my-keys-minor-mode-map (kbd "M-5")  'kill-buffer)

(define-key my-keys-minor-mode-map (kbd "M-t")  'previous-buffer)

(define-key my-keys-minor-mode-map (kbd "M-s")  'save-buffer)
(define-key my-keys-minor-mode-map (kbd "M-e")  'execute-extended-command)
(define-key my-keys-minor-mode-map (kbd "M-q")  'keyboard-quit)

(define-key my-keys-minor-mode-map (kbd "M-o")  'ido-find-file)
(define-key my-keys-minor-mode-map (kbd "M-p")  'recentf-ido-find-file)

(define-key my-keys-minor-mode-map (kbd "M-9")  (kbd "C-x o"))
(define-key my-keys-minor-mode-map (kbd "M-1")  (kbd "C-x 1"))
(define-key my-keys-minor-mode-map (kbd "M-2")  (kbd "C-x 2"))
(define-key my-keys-minor-mode-map (kbd "M-3")  (kbd "C-x 3"))
(define-key my-keys-minor-mode-map (kbd "M-0")  (kbd "C-x 0"))

(define-key my-keys-minor-mode-map (kbd "M-,")  (kbd "C-d"))



(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

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

;;(define-key my-keys-minor-mode-map (kbd "C- S k") 'windmove-down)
;;(define-key my-keys-minor-mode-map (kbd "C-S l") 'windmove-right)
;;(define-key my-keys-minor-mode-map (kbd "C-S j") 'windmove-left)   

