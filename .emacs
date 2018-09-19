;;
;; config autoinsert for verilog
;;

(require 'autoinsert)

(setq auto-insert-directory "~/elisp/insert/")
(setq auto-insert-alist
      (nconc '(
	       ("\\.[ds]?vh?$" . ["template.v" my-template])
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
