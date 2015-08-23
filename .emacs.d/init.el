;; el-getを使えるように設定
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; パッケージの設定
(el-get-bundle auto-complete)
(el-get-bundle elscreen)
(el-get-bundle magit)
(el-get-bundle ddskk)
(el-get-bundle use-package)
(el-get-bundle nyan-mode)
(el-get-bundle popwin)
(el-get-bundle org-dotemacs)
(el-get-bundle color-moccur)
(el-get-bundle moccur-edit)
(el-get-bundle undohist)
(el-get-bundle undo-tree)
(el-get-bundle sequential-command)
(el-get-bundle sequential-command-config)
(el-get-bundle lispxmp)
(el-get-bundle paredit)
(el-get-bundle eldoc-extension)
(el-get-bundle ctags)
(el-get-bundle gtags)
(el-get-bundle rst-mode)
(el-get-bundle markdown-mode)
(el-get-bundle pretty-mode)
(el-get-bundle organic-green-theme)

;; load dotemacs
(setq org-dotemacs-default-file "~/.emacs.d/init.org")
(when (require 'org-dotemacs nil t)
  (org-dotemacs-load-default))
