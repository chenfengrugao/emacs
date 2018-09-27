;;
;; .emacs configuration file
;;
;; Author: Chenfeng
;; Update: 2018-9-27
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
 
(setq frame-title-format "%b@%f")

;;
;; define funtion: prepend-path, append-path for load-path
;;

(defun prepend-path ( my-path )
(setq load-path (cons (expand-file-name my-path) load-path)))

(defun append-path ( my-path )
(setq load-path (append load-path (list (expand-file-name my-path)))))

(prepend-path "~/elisp")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize verilog mode
;;

(autoload 'verilog-mode "verilog-mode" "Verilog mode" t)
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))

(global-font-lock-mode t)

(setq verilog-indent-level             2
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

 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))

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
      (cons '(verilog-mode "\\<begin\\>\\|\\<task\\>\\|\\<function\\>\\|\\<class\\>\\|\\<module\\>\\|\\<package\\>\\|(" 
			   "\\<end\\>\\|\\<endtask\\>\\|\\<endfunction\\>\\|\\<endclass\\>\\|\\<endmodule\\>\\|\\<endpackage\\>\\|)"
			   nil
			   verilog-forward-sexp-function)
	    hs-special-modes-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cc-mode config for Qt
;;

(prepend-path "~/elisp/cc-mode-5.33")
(require 'cc-qt-mode)

;; add hide/show hook
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; matlab
;;

(prepend-path "~/elisp/matlab-emacs")
(require 'matlab-load)
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(setq auto-mode-alist (cons '("//.m//'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
(global-font-lock-mode t)
;;(matlab-mode-hilit)
(autoload 'tlc-mode "tlc" "tlc Editing Mode" t)
(add-to-list 'auto-mode-alist '("//.tlc$" . tlc-mode))
(setq tlc-indent-function t)

(put 'downcase-region 'disabled nil)

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
;; enable line number
;;
;;(global-linum-mode 1)
;;(require 'nlinum)
;;
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
;; keyboard binding, adjust them as you like
;;

;; (global-set-key [f2] 'revert-buffer)                 ;; reload buffer
;; (global-set-key [f3] 'set-mark-command)              ;; C-@
;; (global-set-key [f4] 'goto-line)                     ;; M-g g
;;  						      
;; (global-set-key [f5] 'undo)                          ;; C-_
;; (global-set-key [f6] 'beginning-of-buffer)           ;; M-<
;; (global-set-key [f7] 'end-of-buffer)                 ;; M->
;; ;;(global-set-key [f8] 'xxx)                         ;; reserved for vnc
;;  						      
;; (global-set-key [f9] 'cua-mode)                      ;; M-x cua-mode
;; (global-set-key [f10] 'cua-set-rectangle-mark)       ;; replace C-return in cua-mode mode, it is useful in console mode
;; (global-set-key [f11] 'hexl-mode)                    ;; M-x hexl-mode
;; (global-set-key [f12] 'color-rg-search-project)      ;; global search in directories or project
;;  						      
;; (global-set-key (kbd "s-f") 'fastopen)               ;; open file by keywords under cursors
;; (global-set-key (kbd "<s-left>") 'resizeframeleft)   ;; resize frame (known as window)
;; (global-set-key (kbd "<s-right>") 'resizeframeright) ;; resize frame (known as window)
