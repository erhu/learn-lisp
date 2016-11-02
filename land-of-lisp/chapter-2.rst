第二章笔记
=============

1. Use ``defparameter`` and ``defvar`` to define global variable;
2. Use ``defun`` to define gloabl function;
3. Use ``setf`` to change the value of global variable(``*XXX*``);
4. Define local variable using ``let``:

::

   (let ((a 1)
         (b 2))
     (+ a b))


5. Define local function: ``flet``:

::

   (flet ((f (n)
             (+ n 10)))
     (f 5))

6. ``labels``, let you call one local function from another, and it allows you to have a function call itself:

::
   
   (labels ((a (n)
               (+ n 5))
            (b (n)
               (+ (a n) 6)))
     (b 10))
