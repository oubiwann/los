;;;; The Clojure Cookbook provides the following examples for polymorphic
;;;; functions:
;;;;
;;;; * map-based dispatch
;;;; * multi-methods
;;;; * Clojure protocols
(defmodule polymorph
  (export all))

;;; # Map-based dispatch
;;;
;;; In this example, dispatch and implementation are inextrcably linked,
;;; which would make maintanence difficult in a project that relied upon
;;; this approach:
;;;
;;;   (defn area
;;;     "Calculate the area of a shape"
;;;     [shape]
;;;     (condp = (:type shape)
;;;       :triangle (* (:base shape) (:height shape) (/ 1 2))
;;;       :rectangle (* (:length shape) (:width shape))))
;;;
;;;   (area {:type :triangle :base 2 :height 4}) ;; -> 4N
;;;   (area {:type :rectangle :length 2 :width 4}) ;; -> 8N

;; In LFE, we can duplicate that with the following:

(defun area-1
  ((`(#(type triangle) #(base ,b) #(height ,h)))
    (* b h (/ 1 2)))
  ((`(#(type rectangle) #(length ,l) #(width ,w)))
    (* l w)))

;; We could then use this in the following manner:
;;
;;   > (area-1 '(#(type triangle) #(base 2) #(height 4)))
;;   4.0
;;   > (area-1 '(#(type rectangle) #(length 2) #(width 4)))
;;   8

;;; # Multi-methods
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

;; In LFE, there are no multi-method related macros. But let's explore
;; the separation of dispatch and implementation:

(defun area-2
  ((`(#(type triangle) #(base ,b) #(height ,h)))
   (area-2-triangle b h))
  ((`(#(type rectangle) #(length ,l) #(width ,w)))
   (area-2-rectangle l w)))

(defun area-2-triangle (b h)
  (* b h (/ 1 2)))

(defun area-2-rectangle (l w)
  (* l w))

;; This would be used the same as the previous example:
;;
;;   > (area-2 '(#(type triangle) #(base 2) #(height 4)))
;;   4.0
;;   > (area-2 '(#(type rectangle) #(length 2) #(width 4)))
;;   8
;;
;; However, we still have to update area every time we add a new concrete
;; implementation. So how could we make area more generic and easier to
;; extend?

(defun area
  ((`(,type . ,rest))
   (dispatch 'area type rest)))

(defun dispatch
  ((fname `#(type ,type) args)
   (call (MODULE) (list_to_atom (++ (atom_to_list fname)
                                    "-"
                                    (atom_to_list type))) args)))

(defun area-triangle
  ((`(#(base ,b) #(height ,h)))
   (* b h (/ 1 2))))

(defun area-rectangle
  ((`(#(length ,l) #(width ,w)))
   (* l w)))

;; This example uses the (MODULE) macro to dynamically call functions. As
;; such, we'll need to compile these from a module, not just copy/paste
;; them into the REPL:
;;
;;   (c "examples/no-macros/polymorph.lfe")
;;   #(module polymorph)
;;   > (polymorph:area '(#(type triangle) #(base 2) #(height 4)))
;;   4.0
;;   > (polymorph:area '(#(type rectangle) #(length 2) #(width 4)))
;;   8
;;
;; If we want to add a new type ("shape", in this case) all we have to do
;; is add a function area-<shape> -- we don't have to touch the main area
;; function nor the dispatch function:

(defun area-square
  ((`(#(side ,s)))
   (* s s)))

(defun area-circle
  ((`(#(radius ,r)))
   (* (math:pi) r r)))

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