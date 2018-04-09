;; Basic UI
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq line-number-mode t
      column-number-mode t)
(load "font-lock")
(setq font-lock-maximum-size nil)
(fset 'yes-or-no-p 'y-or-n-p)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Backup and auto-saves
(setq backup-inhibited t)
(auto-save-mode nil)

;; Modes
(add-to-list 'load-path "~/.emacs.d/python-mode")
(add-to-list 'load-path "~/.emacs.d/web-mode")
(require 'python-mode)
(require 'web-mode)
(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode) t)
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . xml-mode) t)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode) t)
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))


;; Remote Editing with Ibuffer && Tramp
(setq tramp-default-method "ssh")

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(add-to-list 'load-path "~/.emacs.d/ibuffer-tramp")
(require 'ibuffer-tramp)
(add-hook 'ibuffer-hook
  (lambda ()
    (ibuffer-tramp-set-filter-groups-by-tramp-connection)
    (ibuffer-do-sort-by-alphabetic)))

;; IBuffer: Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; IBuffer: Modify the default ibuffer-formats
  (setq ibuffer-formats
	'((mark modified read-only " "
		(name 18 18 :left :elide)
		" "
		(size-h 9 -1 :right)
		" "
		(mode 16 16 :left :elide)
		" "
		filename-and-process)))


;; Terminal and Keybinding Portability
(defun xterm-cfg ()
  (set-face-foreground 'font-lock-function-name-face "orange")
  (set-face-foreground 'font-lock-comment-face "blue")
  (set-face-foreground 'font-lock-string-face "yellow")
  (set-face-underline-p 'font-lock-string-face nil)
  (setq vc-mode-face 'modeline-buffer-id)
  (make-face-unitalic 'font-lock-string-face)
  (make-face-unitalic 'font-lock-function-name-face))

(defun rxvt-cfg ()
  (global-unset-key "\e[")
  (xterm-cfg)
  (global-set-key "\e[14" 'backward-kill-word)
  )

(defun dispatch-termtype (term)
  (cond ((equal term "xterm") (xterm-cfg))
        ((equal term "xterm-color") (xterm-cfg))
        ((equal term "rxvt") (rxvt-cfg))
        ((equal term "screen") (xterm-cfg))))

(if (eq window-system 'x)
    (dispatch-termtype "x-windows")
  (dispatch-termtype (getenv "TERM")))


(set-background-color "#CECECE")
;(set-default-font "Courier-13")

;; http://raebear.net/comp/emacscolors.html
(set-face-foreground 'font-lock-comment-face "dark blue")            ;; #00008b
(set-face-foreground 'font-lock-string-face "forest green")          ;; #228b22
(set-face-foreground 'font-lock-keyword-face "firebrick4")           ;; #8b1a1a
(set-face-foreground 'font-lock-builtin-face "firebrick4")
(set-face-foreground 'font-lock-variable-name-face "Black")          ;; #000
(set-face-foreground 'font-lock-function-name-face "MediumOrchid4")  ;; #7a378b
(set-face-foreground 'font-lock-type-face "MediumOrchid4")
;; LightGoldenrod2   #eedc82

;; Software Development Environment
(add-hook 'python-mode-hook 'turn-on-font-lock)
(add-hook 'ruby-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c++-mode-hook 'turn-on-font-lock)
(add-hook 'perl-mode-hook 'turn-on-font-lock)
;(add-hook 'tex-mode-hook 'turn-on-font-lock)
;(add-hook 'latex-mode-hook 'turn-on-font-lock)
;(add-hook 'texinfo-mode-hook 'turn-on-font-lock)
;(add-hook 'sql-mode-hook 'turn-on-font-lock)
(add-hook 'xml-mode-hook 'turn-on-font-lock)
(add-hook 'html-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'turn-on-font-lock)

(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix t))

(defun uncr-buffer ()
  "Removes ^M from the end of lines on the entire buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\C-m$" nil t)
      (replace-match "" nil nil))
    ))

(defun cr-buffer ()
  "Adds ^M to the end of every line in the buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (condition-case nil
      (while (re-search-forward "$" nil t)
        (replace-match "\C-m" nil nil)
        (forward-char 1))
      (end-of-buffer))
    ))
(put 'narrow-to-region 'disabled nil)


;; Whitespace Controls
(setq
  c-basic-offset 4
  c-default-style "gnu"
  tab-width 4
  default-tab-width 4
  sh-basic-offset 4
  sh-tab-width 4
  py-indent-offset 4
  php-indent-offset 4
  xml-basic-offset 4
  xml-tab-width 4
  html-basic-offset 4
  html-tab-width 4
  java-basic-offset 4
  java-tab-width 4
  jde-basic-offset 4
  jde-tab-width 4
  indent-tabs-mode nil
  require-final-newline t
)
(setq-default indent-tabs-mode nil)
(setq-default buffer-file-coding-system 'undecided-unix)
(add-hook 'find-file-hook 'uncr-buffer)


(setq completion-ignored-extensions
  (append completion-ignored-extensions
    '(".pdf" ".png" ".pyc" ".pyo")))

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
