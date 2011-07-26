;; WLR mode
(require 'whole-line-or-region)
(whole-line-or-region-mode 1)

;; scheme
(setq scheme-program-name "mit-scheme")

(require  'delete-twecl)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; my-keys
;;(require 'my-keys)
;;(my-keys-minor-mode 1)

;; modal-mode
(require 'modal-mode)
(modal-mode)


