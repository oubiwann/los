(defmodule los-util
  (export all))

(defun get-los-version ()
  (lutil:get-app-version 'los))

(defun get-version ()
  (++ (lutil:get-versions)
      `(#(los ,(get-los-version)))))
