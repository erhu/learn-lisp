;; get the biggest number
;; reduce
(reduce (lambda (best item)
                (if (> item best)
                    item
                    best))
        '(7 4 6 5 2)
        :initial-value 0)

;; map
(map 'list
     (lambda (x)
       (if (eq x #\s)
           #\S
           x))
     "this is a string")


(subseq "American" 2 6)
(sort '(2 3 0 98 7 45 23) #' <)