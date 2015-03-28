(defmodule unit-los-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest noop
  (is-equal 'noop (los:noop)))
