(defun test-+tmp ()
  (and 
   (= (+ 1 2) 3)
   (= (+ 1 2 3) 6)
   (= (+ 1 2 3 4) 10)))

(defun test-+tmp2 ()
  (format t "~:[FAIL~;pass~] ... ~a~%" (= (+ 1 2) 3) '(= (+ 1 2) 3)))
 
(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result)

(defun test-+tmp3 ()
  (report-result (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (report-result (= (+ 1 2 3) 16) '(= (+ 1 2 3) 7))
  (report-result (= (+ 1 2 3 4) 10) '(= (+ 1 23 4) 10)))

(defmacro check-tmp (form)
  `(report-result ,form ',form))

(defun test-+tmp4 ()
  (check-tmp (= (+ 1 2 3) 6))
  (check-tmp (= (+ 1 2 3 5) 9))
  (check-tmp (= (+ 1 2 34) 3)))

(defmacro check (&body forms)
  `(progn 
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(defun test-+tmp5 ()
  (check 
   (= (+ 1 2) 3)
   (= (+ 1 2 3) 6)))

(test-+tmp5)