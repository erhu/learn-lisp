(defparameter *nodes* '(
                        (客厅 (你现在客厅里，一个巫师正在长沙发上打呼噜。))
                        (花园 (你现在美丽的花园里，前面有一口井。))
                        (阁楼 (你现在阁楼上，角落里有一只巨大的焊枪。))))

(defun describe-location (location nodes)
  (cadr (assoc location nodes)))


(defparameter *edges* '((客厅 (花园 向西 门)
                         (阁楼 上楼 梯子))
                        (花园 (客厅 向东 门))
                        (阁楼 (客厅 下楼 梯子))))

(defun describe-path (edge)
  `(从,(car edge)通过,(third edge),(second edge)可以到达。))
;(describe-path '(客厅 向东 门))

(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))
;(describe-paths '客厅 *edges*) ==> (从 花园 通过 门 向西 可以到达。 从 阁楼 通过 梯子 上楼 可以到达。)

(defparameter *objects* '(酒 篮子 青蛙 链子))
(defparameter *object-locations* '((酒 客厅)
                                   (篮子 客厅)
                                   (链子 花园)
                                   (青蛙 花园)))

(defun objects-at (loc objs obj-locs)
  (labels ((at-loc-p (obj)
             (eq (second (assoc obj obj-locs)) loc)))
    (remove-if-not #'at-loc-p objs)))
;(objects-at '客厅 *objects* *object-locations*) ==> (篮子 酒)

(defun describe-objects (loc objs obj-loc)
  (labels ((describe-obj (obj)
             `(你可以看到地上有,obj 。)))
    (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))

;(describe-objects '客厅 *objects* *object-locations*)

(defparameter *location* '客厅)
(defun look ()
  (append (describe-location *location* *nodes*)
          (describe-paths *location* *edges*)
          (describe-objects *location* *objects* *object-locations*)))

(defun walk (direction)
  (let ((next (find direction
                    (cdr (assoc *location* *edges*))
                    :key #'second)))
    (if next
        (progn (setf *location* (car next))
               (look))
        '(这条路行不通.))))

;;不知道肿么回事，运行不了啊:(
(defun pickup (object)
  (cond ((member object
                 (objects-at *location* *objects* *object-locations*))
         (push (list object 'body) *object-locations*)
         `(你捡到了 ,object ))
        (t '(你拿不到这个东西))))

(defun inventory ()
  (cons 'items- (objects-at 'body *objects* *object-locations*)))


;; =============
;;  chapter-6
;; =============

(defparameter *allowed-commands* '(look walk pickup inventory))

(defun game-read ()
  (let ((cmd (read-from-string 
              (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
             (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defun game-eval (sexp)
  (if (member (car sexp) *allowed-commands*)
      (eval sexp)
      '(i do not know that command.)))

(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
          (rest (cdr lst)))
      (cond ((eq item #\space) (cons item (tweak-text rest caps lit)))
            ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
            ((eq item #\") (tweak-text rest caps (not lit)))
            (lit (cons item (tweak-text rest nil lit)))
            ((or caps lit) (cons (char-upcase item) (tweak-text rest nil lit)))
            (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

(defun game-print (lst)
  (princ (coerce (tweak-text (coerce (string-trim "() "
                                                  (prin1-to-string lst))
                                     'list)
                             t
                             nil)
                 'string))
  (fresh-line))

;; repl function
(defun game-repl ()
  (let ((cmd (game-read)))
    (unless (eq (car cmd) 'quit)
      (game-print (game-eval cmd))
      (game-repl))))

