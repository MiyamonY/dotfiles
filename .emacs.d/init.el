;; el-getの設定
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; OS固有の設定
(cond
 ((eq system-type 'darwin)              ;mac
  (defvar init-proofgeneral-path "/usr/share/usr/bin/emacs/site-lisp/site-start.d")
  (setq ns-command-modifier (quote meta)) ; comanndキーにmetaキー
  (setq ns-alternate-modifier (quote super))
  (setq use-dialog-box nil)             ; プロンプトを使用しない
  (let ((path-from-shell                ; PATHの設定
	 (replace-regexp-in-string
	  "[ \t\n]*$" ""
	  (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
 (t                                     ; linux
  (defvar init-proofgeneral-path "/usr/share/emacs/site-lisp/site-start.d")))

;; パッケージの設定
(el-get-bundle exec-path-from-shell)
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
(el-get-bundle multi-term)
(el-get-bundle pretty-mode)
(el-get-bundle organic-green-theme)
(el-get-bundle ace-jump-mode)
(el-get-bundle ace-jump-buffer)
(el-get-bundle ace-isearch)
(el-get-bundle ace-window)
(el-get-bundle helm)
(el-get-bundle ac-helm)
(el-get-bundle open-junk-file)
(el-get-bundle cmake-mode)
(el-get-bundle flycheck)
(el-get-bundle flycheck-color-mode-line)
(el-get-bundle flycheck-pos-tip)
(el-get-bundle virtualenvwrapper)
(el-get-bundle yasnippet)
(el-get-bundle pcre2el)
(el-get-bundle helm-c-yasnippet)
(el-get-bundle helm-descbinds)
(el-get-bundle helm-swoop)
(el-get-bundle helm-migemo)
(el-get-bundle highlight-symbol)
(el-get-bundle python)
(el-get-bundle ipython)
(el-get-bundle viewer)
(el-get-bundle visual-regexp-steroids)
(el-get-bundle git-gutter)
(el-get-bundle jinja2-mode)
(el-get-bundle hl-line+)
(el-get-bundle bm)
(el-get-bundle helm-project)
(el-get-bundle wanderlust)
(el-get-bundle csharp-mode)
(el-get-bundle helm-ls-git)

;; load dotemacs
(setq org-dotemacs-default-file "~/.emacs.d/init.org")
(when (require 'org-dotemacs nil t)
  (org-dotemacs-load-default))
