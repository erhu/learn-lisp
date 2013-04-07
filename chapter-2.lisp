1. 描述下列表达式求值之后的结果：
(a) (+ (- 5 1) (+ 3 7)) -->  14
(b) (list 1 (+ 2 3)) --> (1 5)
(c) (if (listp 1) (+ 1 2) (+ 3 4)) --> 7
(d) (list (and (listp 3) t) (+ 1 2)) --> (nil 3)

2. 给出 3 种不同表示 (abc) 的 cons 表达式 。
   (cons 'a (cons 'b (cons 'c nil)))
   (cons 'a '(b c))

3. 使用 car 与 cdr 来定义一个函数，返回一个列表的第四个元素。
   (defun our-fourth (lst)
       (cadddr lst))

4. 定义一个函数，接受两个实参，返回两者当中较大的那个。
   (defun our-max (x y)
	   (if (> x y)
	       x
	       y))
     
5. 这些函数做了什么？

(a) (defun enigma (x)      
      (and (not (null x))
           (or (null (car x))     
               (enigma (cdr x)))))
   判断列表X是否包含NIL
    
(b) (defun mystery (x y)
      (if (null y)
          nil
          (if (eql (car y) x)
              0
              (let ((z (mystery x (cdr y))))
                (and z (+ z 1))))))
   返回元素X中列表Y中的索引号


6. 下列表达式， x 该是什么，才会得到相同的结果？

(a) > (car (x (cdr '(a (b c) d)))) --> B
      car
(b) > (x 13 (/ 1 0)) --> 13
      or
(c) > (x #'list 1 nil) --> (1)
      apply


7. 只使用本章所介绍的操作符，定义一个函数，它接受一个列表作为实参，如果有一个元素是列表时，就返回真。
(defun list-contains-list (lst)
   (let ((result nil))
     (dolist (obj lst)
       (if (listp obj)
	   (setf result t)))
     result))

8. 给出函数的迭代与递归版本：
 8-1.接受一个正整数，并打印出数字数量的点。
 8-2.接受一个列表，并返回 a 在列表里所出现的次数。

9. 一位朋友想写一个函数，返回列表里所有非 nil 元素的和。他写了此函数的两个版本，但两个都不能工作。请解释每一个的错误在哪里，并给出正确的版本。

(a) (defun summit (lst)      (remove nil lst)      (apply #'+ lst))(b) (defun summit (lst)      (let ((x (car lst)))        (if (null x)            (summit (cdr lst))            (+ x (summit (cdr lst))))))#1.