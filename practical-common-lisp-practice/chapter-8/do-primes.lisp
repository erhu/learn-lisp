;;;; 打印 0-19 间的素数

;; 判断一个数字是否为素数
(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

;; 取number的下一个素数
(defun next-prime (number)
  (loop for n from number when (primep n) return n))

;; 使用DO完成
(do ((p (next-prime 0) (next-prime (1+ p))))
    ((> p 19))
  (format t "~d " p))

;; 使用宏完成
(defmacro do-primes ((var start end) &rest body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
	 ((> ,var ,end))
       ,@body)))

(do-primes (p 0 99) (format t "~d " p))	