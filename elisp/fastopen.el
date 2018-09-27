;;; fastopen.el

;; Copyright (C)
;; Author: Bill Chen <chenfengrugao@yahoo.com>
;;
;; This lisp script is free software, which uses the GNU GPL-3.0.
;; See <http://www.gnu.org/licenses/>.

;; USAGE
;; =====
;; 

;; KNOWN BUGS / BUG REPORTS
;; ========================
;; https://github.com/chenfengrugao/fastopen

;; INSTALLING THE MODE
;; ===================
;;


;;; History:
;;
;;

;;; Code:
;;

;;
;; >= emacs 24.4
;;
(require 'subr-x)

;;
;; get fullname by linux `find` command
;;
(defun getroot ()
  "get root path of current project"
  (interactive)
  (shell-command-to-string "depth")
)

(defun getfullpath (s)
  "get full path name"
  (interactive)
  (progn
    (setq prjroot (getroot))
    ;;find file
    (setq fullpath (shell-command-to-string (concat "find " prjroot " -name '" s ".v'")))
    (if (string-equal fullpath "")
	(progn 
	  (setq fullpath (shell-command-to-string (concat "find " prjroot " -name '" s ".sv'")))
          (if (string-equal fullpath "")
	      (setq fullpath (shell-command-to-string (concat "find " prjroot " -name '" s ".svh'"))))
	)
    )
    
    ;;return value
    (string-trim fullpath)
  );;progn
)

;;
;; fast open file from current line
;;
(defun fastopen ()
  "get selected text or current line as filename and open it"
  (interactive)
  (let (p1 p2 myfilename)
    (if (use-region-p)
	;use selected text as defaults
	(setq p1 (region-beginning) p2 (region-end))
        ;otherwise use the entire line
        (setq p1 (line-beginning-position) p2 (line-end-position)))
    (progn
      (setq myfilename (buffer-substring-no-properties p1 p2))
      ;;search filename in prj dirs if no file name extension
      (if (equal (file-name-extension myfilename) nil)
	  (setq myfilename (getfullpath (substitute-env-vars myfilename))))
      (if (equal myfilename "")
	  (message "file not exists")
	  (if (not (file-exists-p myfilename))
	      (message "file not exists")
              (find-file myfilename))
      ) ;end of if
    ) ;end of progn
  ) ;end of let
) ;end of defun

;;
;; binding: win + f
;;
;; (global-set-key (kbd "s-f") 'fastopen)

;;; fastopen.el ends here

