```
#!/usr/bin/env -S sbcl --script
;; ^ or whatever cl implementation you use

(load "jobs.lisp")


(define-jobs
    "test"
    (cmd! "ls -l")
    "argtest" 
    (format t "bober= ~a~%" (arg! "-bober")))

;; ^ you can run these by name if this was `script.lisp`:
;; ./script.lisp test
;; ./script.lisp argtest -bober yoben


(run-main) ;; `run-main` listens for input

```
