;; 只输出一行内容;
(defun read-hosts-1 ()
  (let ((in (open "/etc/hosts")))
    (format t "~a~%" (read-line in))
    (close in)))

;; 输出一行内容(如果流不为空);
(defun read-hosts-2 ()
  (let ((in (open "/etc/hosts" :if-does-not-exist nil)))
    (when in
      (format t "~a~%" (read-line in))
      (close in))))

;; 输出文件所有内容;
(defun read-hosts-3 ()
  (let ((in (open "/etc/hosts" :if-does-not-exist nil)))
    (when in
      (loop for line = (read-line in nil)
	   while line do (format t "~a~%" line))
      (close in))))

;; 输出文件所有内容(不用考虑关闭流);
(defun read-hosts-4 ()
  (with-open-file (stream "/etc/hosts")
    (when stream
      (loop for line = (read-line stream nil)
	   while line do (format t "~a~%" line)))))
      