;; guess-my-number

(defun guess-my-number ()
  (ash (+ *small* *big*) -1))

(defun smaller () 
  (setf *big* (1- (guess-my-number)))
  (guess-my-number))

(defun bigger () 
  (setf *small* (1+ (guess-my-number)))
  (guess-my-number))

(defun start-over ()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess-my-number))

;游戏玩法，玩家先在心里默选一个数字X(1~100)，然后运行
;(start-over), 如果电脑输出的数字比X大，玩家输入(smaller)，意为:我心中的数字更小；
;同理，如果电脑输出的数字比X小，玩家输入(bigger)，意为:我心中的数字更大；
;直到计算机找到X。
