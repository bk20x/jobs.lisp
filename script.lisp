#!/usr/bin/env -S sbcl --script
(load "jobs.lisp")




(defparameter sources
  (mapcar
   (lambda (path)
    (concatenate 'string "src/" path))
   '("fpscam.c" "main.c")))

(define-jobs
    "build"
    (cmd! (format nil "gcc ~{~a~^ ~} -lm -lraylib -o bober" sources)))

(run-main)
