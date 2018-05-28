(use-package hl-line
  :init
  (progn
    (defun global-hl-line-timer-function ()
      (global-hl-line-unhighlight-all)
      (let ((global-hl-line-mode t))
        (global-hl-line-highlight)))
    (setq global-hl-line-timer
          (run-with-idle-timer 0.05 t 'global-hl-line-timer-function))))