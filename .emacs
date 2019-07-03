;;
;; .emacs configuration file
;;
;; Author: Chenfeng
;; Last Update: 2019-03-25
;; License: GNU General Public License v3.0 (refer to `LICENSE')
;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'subr-x)

(setq-default abbrev-mode nil)
;;(read-abbrev-file "~/.abbrev_defs")
(setq save-abbrevs nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(ediff-split-window-function 'split-window-horizontally))

;;
;; font and coding-system setting on windows
;;

(if (eq system-type 'windows-nt)
    (custom-set-faces
     '(default ((t (:family "新宋体" :foundry "outline" :slant normal :weight normal :height 105 :width normal)))))
)

(if (eq system-type 'windows-nt)
    (progn
      (set-language-environment "utf-8")
      (set-buffer-file-coding-system 'utf-8)
      (set-terminal-coding-system 'utf-8)
      (set-keyboard-coding-system 'utf-8)
      (set-selection-coding-system 'utf-8)
      (set-default-coding-systems 'utf-8)
      (set-clipboard-coding-system 'utf-8)  
      (modify-coding-system-alist 'process "*" 'utf-8)  
      (setq-default pathname-coding-system 'utf-8)  
      (prefer-coding-system 'utf-8)
      (setq default-process-coding-system '(utf-8 . utf-8))  
      (setq locale-coding-system 'utf-8)
      (setq file-name-coding-system 'utf-8) 
      (setq default-buffer-file-coding-system 'utf-8)  
)

(setq frame-title-format "%b@%f")


;;(setq x-select-enable-clipboard t)


;;
;; define funtion: prepend-path, append-path for load-path
;;

(defun prepend-path ( my-path )
(setq load-path (cons (expand-file-name my-path) load-path)))

(defun append-path ( my-path )
(setq load-path (append load-path (list (expand-file-name my-path)))))

;;
;; ~ means /home/xxx in linux and C:/Users/xxx/AppData/Roaming in Windows7, for example.
;; but ~ points to C:/Users/xxx when you use emacs with git-bash.
;; If you don't sure which path exactly points to, you can use C-f ~ to double check.
;;

(prepend-path "~/elisp")
(append-path "~/elisp/verilog-mode")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize verilog mode
;;

(autoload 'verilog-mode "verilog-mode" "Verilog mode" t)
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))

(global-font-lock-mode t)

(setq verilog-indent-level            2
      verilog-indent-level-module      2
      verilog-indent-level-declaration 2
      verilog-indent-level-behavioral  2
      verilog-indent-level-directive   2
      verilog-case-indent              2
      verilog-auto-newline             nil  ;;;disable auto newline after semicolons
      verilog-auto-indent-on-newline   t
      verilog-tab-always-indent        t
      verilog-auto-endcomments         t
      verilog-minimum-comment-distance 40
      verilog-indent-begin-after-if    t
      verilog-auto-lineup              'declarations
      verilog-highlight-p1800-keywords t
      verilog-linter                   "my_lint_shell_command"
      verilog-auto-inst-param-value    t
      )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; spice-mode
;;

;;(add-to-list 'load-path "~/elisp/spice-mode")
;;(require 'spice-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete
;;

(add-to-list 'load-path "~/elisp/auto-complete")
(require 'auto-complete-config)
(ac-config-default)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hs-minor-mode
;;

(setq hs-special-modes-alist
      (cons '(verilog-mode "\\<begin\\>\\|\\<case\\>\\|\\<task\\>\\|\\<function\\>\\|\\<class\\>\\|\\<module\\>\\|\\<package\\>\\|(" 
			   "\\<end\\>\\|\\<endcase\\>\\|\\<endtask\\>\\|\\<endfunction\\>\\|\\<endclass\\>\\|\\<endmodule\\>\\|\\<endpackage\\>\\|)"
			   nil
			   verilog-forward-sexp-function)
	    hs-special-modes-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cc-mode config for Qt
;;

(prepend-path "~/elisp/cc-mode-5.33")
;;(require 'cc-qt-mode)

;; add hide/show hook
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'verilog-mode 'hs-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; matlab
;;

;;(prepend-path "~/elisp/matlab-emacs")
;;(load-library "matlab-load")
;;;; Enable CEDET feature support for MATLAB code
;;;; (matlab-cedet-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web-mode
;;

(add-to-list 'load-path "~/elisp/web-mode")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; fastopen
;;

(autoload 'fastopen "fastopen" "fastopen" t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; window resize
;;   enlarge or shrink frame size by moving the right border
;;

(defun resizeframe (d)
  "resize frame, l: left, r: right"
  (interactive)
  (if (equal d "left")
      (set-frame-width nil (- (frame-text-cols) 10))
      (set-frame-width nil (+ (frame-text-cols) 10))
  ) ;end of if
); end of defun

(defun resizeframeleft ()
  "resize frame, left"
  (interactive)
  (resizeframe "left")
)

(defun resizeframeright ()
  "resize frame, right"
  (interactive)
  (resizeframe "right")
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer-move
;;
(add-to-list 'load-path "~/elisp/buffer-move")
(require 'buffer-move)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable line number

;;;; Emacs <= 25
;;(global-linum-mode 1)
;;(require 'nlinum)

;;the following way is only avaliable in Emacs >= 26
(require 'display-line-numbers)
(global-display-line-numbers-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color-rg: a search tool based on ripgrep
;;

(add-to-list 'load-path "~/elisp/color-rg")
(add-to-list 'load-path "~/elisp/projectile")
(require 'color-rg)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; aweshell
;;

;;(add-to-list 'load-path "~/elisp/company-mode")
;;(add-to-list 'load-path "~/elisp/aweshell")
;;(require 'aweshell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autoinsert
;;

(require 'autoinsert)
;;(auto-insert-mode 1)
(setq auto-insert-directory "~/elisp/insert/")
(setq auto-insert-alist
      (nconc '(
	       ("\\.v$" . ["template.v" my-template])
	       ) auto-insert-alist))
(require 'cl)
(defvar template-replacements-alists
  '(("%file%" . (lambda () (file-name-nondirectory (buffer-file-name))))))
(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
	    (progn
	      (goto-char (point-min))
	      (replace-string (car c) (funcall (cdr c)) nil)))
	template-replacements-alists)
  (goto-char (point-max))
  (message "done."))
(add-hook 'find-file-hook 'auto-insert)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; grep and highlight the selected text
;;
(defun grep-current-buffer ()
  "grep string in current buffer"
  (interactive)
  (progn
    ;;grep
    (setq filename (buffer-file-name))
    (setq selected-text (buffer-substring-no-properties (region-beginning) (region-end)))
    (setq grep-result (shell-command-to-string (concat "grep -w -B 1 -A 1 -n " selected-text " " filename)))
    ;;print to *grep*
    (switch-to-buffer-other-window (get-buffer-create "*grep*"))
    (insert (concat filename "\n\n"))
    (insert grep-result)
    ;;highlight
    (setq face 'hi-yellow)
    (hi-lock-face-buffer selected-text face)
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; scala
;;
(add-to-list 'load-path "~/elisp/emacs-scala-mode")
(require 'scala-mode)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; markdown
;;
(add-to-list 'load-path "~/elisp/markdown-mode")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; preview in firefox

(add-to-list 'load-path "~/elisp/flymd")
(require 'flymd)
(defun my-flymd-browser-function (url)
  (let ((browse-url-browser-function 'browse-url-firefox))
    (browse-url url)))
(setq flymd-browser-open-function 'my-flymd-browser-function)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keyboard binding, adjust them as you like
;;

(global-set-key [f2] 'revert-buffer)		   ;; reload buffer
(global-set-key [f3] 'set-mark-command)		   ;; C-@
(global-set-key [f4] 'goto-line)		   ;; M-g g

(global-set-key [f5] 'undo)			   ;; C-_
(global-set-key [f6] 'beginning-of-buffer)	   ;; M-<
(global-set-key [f7] 'end-of-buffer)		   ;; M->
;;(global-set-key [f8] 'xxx)			   ;; reserved for vnc

(global-set-key [f9] 'cua-mode)			   ;; M-x cua-mode
(global-set-key [f10] 'cua-set-rectangle-mark)	   ;; replace C-return in cua-mode mode, it is useful in console mode
(global-set-key [f11] 'hexl-mode)		   ;; M-x hexl-mode
(global-set-key [f12] 'color-rg-search-project)	   ;; global search in directories or project

(windmove-default-keybindings)			   ;; S-<Arrow> goto window, to replace C-x o

(global-set-key (kbd "s-g") 'grep-current-buffer)  ;; grep in current file only
(global-set-key (kbd "s-f") 'fastopen)		   ;; open file by keywords under cursors
(global-set-key (kbd "s-,") 'resizeframeleft)      ;; resize frame (known as window)
(global-set-key (kbd "s-.") 'resizeframeright)     ;; resize frame (known as window)

(global-set-key (kbd "s-<left>") 'shrink-window-horizontally)   ;; win-<Arrow> to resize window
(global-set-key (kbd "s-<right>") 'enlarge-window-horizontally)	;;
(global-set-key (kbd "s-<down>") 'shrink-window)		;;
(global-set-key (kbd "s-<up>") 'enlarge-window)			;;


