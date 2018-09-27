
(defun qt-lineup-topmost-intro-cont (langelem)
  (let ((previous-point (point))(previous-line-end-position (line-end-position)))
    (save-excursion
      ;; Go back to the previous non-blank line, if any.
      (while
          (progn
            (forward-line -1)
            (back-to-indentation)
            (and (> (point) (c-langelem-pos langelem))
                 (looking-at "[ \t]*$"))))
      (if (search-forward "Q_OBJECT" (line-end-position) t)
          (if (or (re-search-forward "private[ \t]*:" previous-line-end-position t)
                  (re-search-forward "protected[ \t]*:" previous-line-end-position t)
                  (re-search-forward "public[ \t]*:" previous-line-end-position t)
                  (re-search-forward "signals[ \t]*:" previous-line-end-position t)
                  )
              '-
            '0
            )
        (progn
          (goto-char previous-point)
          (c-lineup-topmost-intro-cont langelem)
          )
        )
      )
    )
  )
 
(defun qt-lineup-inher-cont (langelem)
  (let ((previous-point (point))(previous-line-end-position (line-end-position)))
    (save-excursion
      ;; Go back to the previous non-blank line, if any.
      (while
          (progn
            (forward-line -1)
            (back-to-indentation)
            (and (> (point) (c-langelem-pos langelem))
                 (looking-at "[ \t]*$"))))
      (if (search-forward "Q_OBJECT" (line-end-position) t)
          (if (or (re-search-forward "private[ \t]+slots[ \t]*:" previous-line-end-position t)
                  (re-search-forward "protected[ \t]+slots[ \t]*:" previous-line-end-position t)
                  (re-search-forward "public[ \t]+slots[ \t]*:" previous-line-end-position t)
                  (re-search-forward "private[ \t]+signals[ \t]*:" previous-line-end-position t)
                  (re-search-forward "protected[ \t]+signals[ \t]*:" previous-line-end-position t)
                  (re-search-forward "public[ \t]+signals[ \t]*:" previous-line-end-position t)
                  )
              '-
            '0
            )
        (progn
          (goto-char previous-point)
          (c-lineup-multi-inher langelem)
          )
        )
      )
    )
  )
 
(setq mw-c-style
      '((c-auto-newline                 . nil)
        (c-basic-offset                 . 2)
        (c-comment-only-line-offset     . 0)
        (c-echo-syntactic-information-p . t)
        (c-hungry-delete-key            . t)
        (c-tab-always-indent            . t)
        (c-toggle-hungry-state          . t)
        (c-hanging-braces-alist         . ((substatement-open after)
                                          (brace-list-open)))
        (c-offsets-alist                . ((arglist-close . c-lineup-arglist)
                                           (case-label . +)
                                           (substatement-open . 0)
                                           (topmost-intro-cont . qt-lineup-topmost-intro-cont)
                                           (inher-cont . qt-lineup-inher-cont)
                                           (block-open . 0) ; no space before {
                                           (inline-open . 0) ; no space before {
                                           (knr-argdecl-intro . -)))
        (c-hanging-colons-alist         . ((member-init-intro before)
                                           (inher-intro)
                                           (case-label after)
                                           (label after)
                                           (access-label after)))
;       (c-at-vsemi-p-fn                . qt-at-vsemi-after-q-object)
;       (c-vsemi-status-unknown-p       . qt-vsemi-status-unknown-p)
        (c-cleanup-list                 . (scope-operator
                                           empty-defun-braces
                                           defun-close-semi))))
      
 
;; Construct a hook to be called when entering C mode
(defun lconfig-c-mode ()
  (progn (define-key c-mode-base-map "\C-m" 'newline-and-indent)
         (define-key c-mode-base-map "\C-z" 'undo)
         (define-key c-mode-base-map [f4] 'speedbar-get-focus)
         (define-key c-mode-base-map [f9] 'insert-breakpoint)
         (define-key c-mode-base-map [f10] 'step-over)
         (define-key c-mode-base-map [f11] 'step-into)
         (c-add-style "Mark's Coding Style" mw-c-style t)))
(add-hook 'c-mode-common-hook 'lconfig-c-mode)
 
(font-lock-add-keywords 'c++-mode '(("\\<\\(Q_OBJECT\\)\\>" . font-lock-constant-face)))
(font-lock-add-keywords 'c++-mode '(("\\<\\(public slots\\|public signals\\|private slots\\|private signals\\|protected slots\\|protected signals\\|signals\\)\\>" . font-lock-keyword-face)))

