(defmodule unit-paip-closure-macros-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "los/include/paip-closure.lfe")

(defclass account (name balance) ((interest-rate 0.06))
  (withdraw (amt) ())
  (deposit (amt) ())
  (balance () balance)
  (name () name)
  (interest () ))

; (defclass account (name)
;   `(defclass account name 0.0 0.06))

(deftest class-and-generic-fns
  (is-equal 1 1))
