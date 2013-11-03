;;Common Lisy Object System 初体验

;;结构式编程，求面积
(defstruct retangle height width)
(defstruct circle radius)

(defun area (x)
  (cond ((retangle-p x)
         (* (retangle-height x) (retangle-width x)))
        ((circle-p x)
         (* pi (expt (circle-radius x) 2)))))

(let ((r (make-retangle)))
  (setf (retangle-height r) 2
        (retangle-width r) 3)
  (area r))

;; 对象式编程，求面积

(defclass rectangle ()
  ((height :accessor rectangle-height)
   (width :accessor rectangle-width)))
;使用:accessor指定存取器，亦可用:write or :reader单独指定读取、写入行为。


(defclass circle ()
  (radius))

(defmethod area ((x rectangle))
  (* (rectangle-height x) (rectangle-width x)))

(defmethod area ((x circle))
  (* pi (expt (slot-value x 'radis) 2)))

(let ((r (make-instance 'rectangle)))
  (setf (slot-value r 'height) 2)
  (setf (slot-value r 'width) 3)
  (area r))

(let ((r (make-instance 'rectangle)))
  (setf (rectangle-height r) 18)
  (setf (rectangle-width r) 9)
  (area r)