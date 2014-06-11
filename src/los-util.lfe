(defmodule los-util
  (export all))

(defun get-los-version ()
  (lfe-utils:get-app-src-version "src/los.app.src"))

(defun get-version ()
  (++ (lfe-utils:get-version)
      `(#(los ,(get-los-version)))))
