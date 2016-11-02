(load "chapter-7")

(defparameter *congestion-city-nodes* nil)
(defparameter *congestion-city-edges* nil)
(defparameter *visited-nodes* nil)
(defparameter *node-num* 30)
(defparameter *edge-num* 45)
(defparameter *worm-num* 3)
(defparameter *cop-odds* 15)

;returns a random node
(defun random-node()
  (1+ (random *node-num*)))


(defun edge-pair(a b)
  (unless (equal a b)
    (list (cons a b) (cons b a))))


(defun make-edge-list()
  (apply #'append (loop repeat *edge-num*
                       collect (edge-pair (random-node) (random-node)))))


(defun direct-edges (node edge-list)
  (remove-if-not (lambda (x)
                   (eql (car x ) node))
                 (edge-list)))

(setq list_1 (list "A" "B" "C"))
(setq list_2 (list "A" "D" "C"))
; in list_1 not in list_2
(set-difference list_1 list_2 :test 'equal) ;=> ("B")
(intersection list_1 list_2 :test 'equal) ;=> ("A" "C")
(remove-duplicates "aBcDAbCd" :test #'char-equal :from-end t) ;=> "aBcD"