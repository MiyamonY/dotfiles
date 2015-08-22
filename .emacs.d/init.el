;; el-get
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; el-get-bundle
(el-get-bundle auto-complete)
(el-get-bundle elscreen)
(el-get-bundle magit)
(el-get-bundle ddskk)
(el-get-bundle use-package)
(el-get-bundle nyan-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; OS固有
;;;;;;;;;;;;;;;;;;;;;;;;;
(cond
 ((eq system-type 'darwin)		;mac
  (defvar init-proofgeneral-path "/usr/share/usr/bin/emacs/site-lisp/site-start.d")
  (setq ns-command-modifier (quote meta)) ; comanndキーにmetaキー
  (setq ns-alternate-modifier (quote super))
  (setq use-dialog-box nil)             ; プロンプトを使用しない
  (let ((path-from-shell                ; PATHの設定
         (replace-regexp-in-string
          "[ \t\n]*$" ""
          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator)))
   ;(define-key global-map [?¥] [?\\])
  )
 (t                                     ; linux
  (defvar init-proofgeneral-path "/usr/share/emacs/site-lisp/site-start.d")))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs version固有
;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar init-emacs-ver
  (cond ((= 24 emacs-major-version)
         (cond ((= 1 emacs-minor-version) 'emacs-24-1)
               ((= 3 emacs-minor-version) 'emacs-24-3)))
        (t 'emacs-other)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; use-package の設定
;;;;;;;;;;;;;;;;;;;;;;;;;
(unless (require 'use-package nil t)
  (defmacro use-package (&rest args)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 文字コード/ ファイル名の設定
;;;;;;;;;;;;;;;;;;;;;;;;;
(set-language-environment "Japanese")  ; emacs のロケールを日本語に
(cond ((eq system-type 'gnu/linux)   ; OS によってコーディングを変える)
       (prefer-coding-system 'utf-8-unix))
      ((eq system-type 'darwin)
       (prefer-coding-system 'utf-8)
       (when (require 'ucs-normalize nil t)
         (setq file-name-coding-system 'utf-8)
         (setq local-coding-system 'utf-8)))
      (t
       (prefer-coding-system 'sjis-dos)     ; Windows ならコーディングを sjis に
       (set-file-name-coding-system 'cp932) ; ファイル名も sjis
       (setq locale-coding-system 'cp932)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; elscreen の設定
;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package elscreen
  :commands
  (elscreen-start)
  :config
  (progn
    (elscreen-set-prefix-key (kbd "C-;"))

    (defmacro elscreen-create-automatically (ad-do-it)
      (` (if (not (elscreen-one-screen-p))
             (, ad-do-it)
           (elscreen-create)
           (elscreen-notify-screen-modification 'force-immediately)
           (elscreen-message "New screen is automatically created"))))

    (defadvice elscreen-next (around elscreen-create-automatically activate)
      (elscreen-create-automatically ad-do-it))

    (defadvice elscreen-previous (around elscreen-create-automatically activate)
      (elscreen-create-automatically ad-do-it))

    (defadvice elscreen-toggle (around elscreen-create-automatically activate)
      (elscreen-create-automatically ad-do-it)))
  :init
  (progn
    (elscreen-start)))


;;;;;;;;;;;;;;;;;;;;;;;;
;;; モードラインの設定
;;;;;;;;;;;;;;;;;;;;;;;;
;;; nyan-mode
(use-package nyan-mode
  :commands
  (nyan-mode)
  :config
  (progn
    (setq nyan-bar-length 10
          nyan-wavy-trail nil)
    (nyan-stop-animation))
  :init
  (nyan-mode))

;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

;; Mode line setup
(defun init-mode-line-setup ()
  (setq-default
   mode-line-format
   '(; Position, including warning for 80 columns
     (:propertize "%4l:" face mode-line-position-face)
     (:eval (propertize "%3c" 'face
                        (if (>= (current-column) 80)
                            'mode-line-80col-face
                          'mode-line-position-face)))
     ;; emacsclient [default -- keep?]
     mode-line-client
     " "
     ;; read-only or modified status
     (:eval
      (cond (buffer-read-only
             (propertize "RO" 'face 'mode-line-read-only-face))
            ((buffer-modified-p)
             (propertize "**" 'face 'mode-line-modified-face))
            (t "NE")))
     ;; directory and buffer/file name
     " "
     (:propertize (:eval (shorten-directory default-directory 30))
                  face mode-line-folder-face)
     (:propertize "%b"
                  face mode-line-filename-face)
     " "
     "["(:propertize mode-name face mode-line-mode-face)"]"
     (vc-mode vc-mode)
     (:propertize mode-line-process face mode-line-process-face)
     (global-mode-string global-mode-string)
     " "
     (:eval (when nyan-mode (list (nyan-create)))) "%p"
     ))

  ;; Extra mode line faces
  (make-face 'mode-line-read-only-face)
  (make-face 'mode-line-modified-face)
  (make-face 'mode-line-folder-face)
  (make-face 'mode-line-filename-face)
  (make-face 'mode-line-position-face)
  (make-face 'mode-line-mode-face)
  (make-face 'mode-line-process-face)
  (make-face 'mode-line-80col-face)

  (set-face-attribute 'mode-line nil
                      :foreground "spring green" :background "gray20"
                      :inverse-video nil
                      :box '(:line-width 2 :color "gray20" :style nil))
  (set-face-attribute 'mode-line-inactive nil
                      :foreground "gray80" :background "gray40"
                      :inverse-video nil
                      :box '(:line-width 4 :color "gray40" :style nil))
  (set-face-attribute 'mode-line-read-only-face nil
                      :inherit 'mode-line-face
                      :foreground "#4271ae"
                      :box '(:line-width 2 :color "#4271ae"))
  (set-face-attribute 'mode-line-modified-face nil
                      :inherit 'mode-line-face
                      :foreground "#c82829"
                      :background "#ffffff"
                      :box '(:line-width 2 :color "#c82829"))
  (set-face-attribute 'mode-line-folder-face nil
                      :inherit 'mode-line-face)
  (set-face-attribute 'mode-line-filename-face nil
                      :inherit 'mode-line-face
                      :foreground "deeppink"
                      :weight 'bold)
  (set-face-attribute 'mode-line-position-face nil
                      :inherit 'mode-line-face
                      :family "Menlo" :height 100)
  (set-face-attribute 'mode-line-mode-face nil
                      :inherit 'mode-line-face)
  (set-face-attribute 'mode-line-process-face nil
                      :inherit 'mode-line-face)
  (set-face-attribute 'mode-line-80col-face nil
                      :inherit 'mode-line-position-face
                      :foreground "black" :background "#eab700"))

(init-mode-line-setup)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;; キーバインドの設定
;;;;;;;;;;;;;;;;;;;;;;;;;
(keyboard-translate ?\C-h ?\C-?)						; C-hをBackSpaceキーに変更
(bind-key "\C-h" nil)
(bind-key "C-m" 'newline-and-indent)		; C-m に改行 インデントを割り当てる(
(bind-key "C-c l" 'toggle-truncate-lines)	; C-c l に折り返しを割り当てる
(bind-key "M-l" 'goto-line)
(bind-key "C-c i" 'init-open-dotemacs) ; C-c で init ファイルオープン
(bind-key "C-c j" 'split-window-horizontally)
(bind-key "C-c u" 'split-window-vertically)
(bind-key "C-c r" 'query-replace)

