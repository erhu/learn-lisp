;;; run-length encoding
(defun compress (x)
  (if (consp x)
      (compr (car x) 1 (cdr x))
      x))

;;参数说明:当前元素、下一个元素的索引、列表
(defun compr (elt n lst)
  (if (null lst)
      (list (n-elts elt n))
      (let ((next (car lst)));next:下一个元素
        (if (eql next elt);当前元素等于下一个元素
            (compr elt (+ n 1) (cdr lst))
            (cons (n-elts elt n)
                  (compr next 1 (cdr lst)))))))

;; 生成列表，表示有 N 个 ELT 元素
(defun n-elts (elt n)
  (if (> n 1)
      (list n elt)
      elt))

;;;====================================
;; Run-length decoding
(defun uncompress (lst)
  (if (null lst)
      nil
      (let ((elt (car lst))
	    (rest (uncompress (cdr lst))))
	(if (consp elt)
	    (append (apply #'list-of elt)
		    rest)
	    (cons elt rest)))))

(defun list-of (n elt)
  (if (zerop n)
      nil
      (cons elt (list-of (- n 1) elt))))


(defun mirror? (s)
  (let ((len (length s)))
    (and (evenp len)
	 (let ((mid (/ len 2)))
	   (equal (subseq s 0 mid)
		  (reverse (subseq s mid)))))))

;;================ shortest path
(defun shortest-path (start end net)
  (bfs end (list (list start)) net))

(defun bfs (end queue net)
  (if (null queue)
      nil
      (let ((path (car queue)))
	(let ((node (car path)))
	  (if (eql node end)
	      (reverse path)
	      (bfs end
		   (append (cdr queue)
			   (new-paths path node net))
		   net))))))

(defun new-paths (path node net)
  (mapcar #'(lambda (n)
	      (cons n path))
	  (cdr (assoc node net))))