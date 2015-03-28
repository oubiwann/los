(eval-when-compile
  (defun make-clause
    ;; Translate a message from define-class into a case clause.
    (((cons first) (cons second remainder))
      `(,first (lambda ,second ,remainder))))

  (defun make-generic-fn (message)
    "Define an object-oriented dispatch function for a message,
    unless it has already been defined as one."
    )
  )

(defmacro defclass (class inst-vars class-vars methods)
  `(let ,class-vars
     (defun ,class ,inst-vars
       (lambda (message)
         (case message
           ,@(lists:map #'make-clause/1 methods))))
     (defun get-method (object message)
       (funcall object message))
     (lists:map #'make-generic-fn/1 ',(lists:map #'car methods))
     ))

