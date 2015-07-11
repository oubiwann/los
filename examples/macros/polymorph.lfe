;;;; The Clojure Cookbook provides the following examples for polymorphic
;;;; functions:
;;;;
;;;; * map-based dispatch
;;;; * multi-methods
;;;; * Clojure protocols
(defmodule polymorph
  (export all))

;;; Multi-methods  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; In this example we improve upon the previosu example by separating
;;; dispatch and implementation:
;;;
;;;   (defmulti area
;;;     "Calculate the area of a shape"
;;;     :type)
;;;
;;;   (defmethod area :rectangle [shape]
;;;     (* (:length shape) (:width shape)))
;;;
;;;   (area {:type :rectangle :length 2 :width 4}) ;; -> 8
;;;
;;; If we try to get the area of a new shape without first defining
;;; a new method for it, we get an error:
;;;
;;;   (area {: type :circle :radius 1})
;;;
;;;   -> IllegalArgumentException No method in multimethod 'area' for
;;;   dispatch value: :circle ...
;;;
;;; So let's add a method:
;;;
;;;   (defmethod area :circle [shape]
;;;     (* (. Math PI) (:radius shape) (:radius shape)))
;;;
;;;   (area {:type :circle :radius 1}) ;; -> 3.14159 ...

;; In LFE, there are no multi-method related macros. But the los project
;; offers these for users who wish to use them:


;; XXX add examples once the feature lands ...


;; To use these, we do the same as the others:
;;
;;   > (polymorph:area '(#(type square) #(side 2)))
;;   4
;;   > (polymorph:area '(#(type circle) #(radius 2)))
;;   12.566370614359172
;;
;; As long as the module has been compiled, we can use these functions
;; in the REPL after a slurp:
;;
;;   > (slurp "examples/no-macros/polymorph.lfe")
;;   #(module polymorph)
;;   > (area '(#(type square) #(side 2)))
;;   4
;;   > (area '(#(type circle) #(radius 2)))
;;   12.566370614359172
;;
;; If we were to create some macros to emulate the Clojure multi-methods,
;; we'd need the following:
;;
;;  * a defmulti macro which creates a generic function like our area
;;    function
;;  * a defmethod macro which creates a concrete implementation
;;
;; For an example of that, see ./examples/macros/polymorph.lfe.

;;;  Clojure protocols ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; With Clojure multimethods you’ll need to repeat dispatch
;;; logic for each function and write a combinatorial explosion of
;;; implementations to suit. It would be better if these functions and their
;;; implementations could be grouped and written together. Use Clojure’s protocol
;;; facilities to define a protocol interface and extend it with concrete
;;; implementations:
;;;
;;; Define the "shape" of a Shape object:
;;;
;;;   (defprotocol Shape
;;;     (area [s] "Calculate the area of a shape")
;;;     (perimeter [s] "Calculate the perimeter of a shape"))
;;;
;;; Define a concrete Shape, the Rectangle:
;;;
;;;  (defrecord Rectangle [length width]
;;;     Shape
;;;     (area [this] (* length width))
;;;     (perimeter [this] (+ (* 2 length)
;;;                       (* 2 width))))
;;;
;;;   (-> Rectangle 2 4) ;; -> #user.Rectangle{: length 2, :width 4}
;;;   (area (-> Rectangle 2 4)) ;; -> 8

;; XXX explore this using the defined LFE macros.