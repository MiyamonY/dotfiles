;; el-getの設定

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
  (el-get-bundle exec-path-from-shell)
  (exec-path-from-shell-initialize))
 (t                                     ; linux
  (defvar init-proofgeneral-path "/usr/share/emacs/site-lisp/site-start.d")))

;; パッケージの設定
(el-get-bundle recentf-ext)
(el-get-bundle sync-recentf)
(el-get-bundle elscreen)
(el-get-bundle magit)
(el-get-bundle ddskk)
(el-get-bundle use-package)
(el-get-bundle nyan-mode)
(el-get-bundle popwin)
(el-get-bundle org-dotemacs)
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
(el-get-bundle dracula/emacs :name dracula-theme)
(el-get-bundle ace-jump-buffer)
(el-get-bundle ace-isearch)
(el-get-bundle ace-window)
(el-get-bundle helm)
(el-get-bundle helm-git)
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
(el-get-bundle which-key)
(el-get-bundle helm-ag)
(el-get-bundle markdown-mode)
(el-get-bundle tuareg-mode)
(el-get-bundle emmet-mode)
(el-get-bundle helm-c-flycheck)
(el-get-bundle swift-mode)
(el-get-bundle gtags)
(el-get-bundle helm-gtags)
(el-get-bundle clang-format)
(el-get-bundle irony-mode)
(el-get-bundle flycheck-irony)
(el-get-bundle ghc-mod)
(el-get-bundle yaml-mode)
(el-get-bundle php-mode)
(el-get-bundle magit-gitflow)
(el-get-bundle jedi)
(el-get-bundle py-autopep8)
(el-get-bundle emacs-fish)
(el-get-bundle adoc-mode)
(el-get-bundle auto-complete)
(el-get-bundle ac-helm)
(el-get-bundle doc-mode)
(el-get-bundle migemo)

;; load dotemacs
(setq org-dotemacs-default-file "~/.emacs.d/init.org")
(when (require 'org-dotemacs nil t)
  (org-dotemacs-load-default))
