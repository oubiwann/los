(defmacro defmulti name ()
  `(defun ,name (((cons type rest))
                 ,(los-multi:dispatch name 'type 'rest))))

(defmacro defmulti
  ((`(,name ,params))
   `(defun ,name (((cons type rest))
                  (los-multi:dispatch ,name type rest)))))

(defmacro defmethod
  ((`(,name ,type ,body))
    `(defun ,(los-multi:get-impl-name name type) ,body)))

(defun loaded-multi-methods ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).

  This function needs to be the last one in this include."
  'ok)