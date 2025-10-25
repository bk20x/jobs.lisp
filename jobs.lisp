(require :uiop)

(defstruct config
  :jobs)

(defmacro new-job (&body job)
  `(lambda () ,@job))


(defun run-job (jobname config)
  (let ((fun (gethash jobname (config-jobs config))))
          (eval (funcall fun))))


(defun cmd! (cmd &key silent)
  (if silent (uiop:run-program cmd :output nil)
      (uiop:run-program cmd :output t)))


(defmacro define-jobs (&rest jobs)
  `(progn
     (let ((job-table (make-hash-table :test 'equal)))
       ,@(loop for (key job) on jobs by #'cddr
               collect `(setf (gethash ,key job-table) (new-job ',job)))
       (defparameter *registered-jobs*
         (make-config
          :jobs job-table)))
     (defun run-main ()
       (let ((jobname (car (uiop:command-line-arguments))))
         (if (gethash jobname (config-jobs *registered-jobs*))
             (run-job jobname *registered-jobs*))))))


(defun arg! (flagname)
  (let ((args (uiop:command-line-arguments)))
    (loop for sublist on args
          when (equal (car sublist) flagname)
          return (cadr sublist))))
