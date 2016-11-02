
;; 全局变量 DB, 保存数据;
(defvar *db* nil)

;; 生成一条 host 记录
(defun make-host (host-name ip)
  (list :host-name host-name :ip ip))

;; 添加一条记录到DB
(defun add-host (host)
  (push host *db*))

;; 打印 DB 内容
(defun dump-host ()
  (dolist (host *db*)
    (format t "~{~a: ~10t ~a~%~}~%" host)))

;;提示用户输入
(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

;;录入一每条HOST
(defun prompt-for-host ()
  (make-host
   (prompt-read "host-name")
   (prompt-read "ip")))

;; 连续添加HOST记录
(defun add-hosts ()
  (loop (add-host (prompt-for-host))
     (if (not (y-or-n-p "Another ?[y/n]: ")) (return))))

;; 保存数据到文件(保存内容可被LISP读取器读取)
(defun save-db-to-file (filename)
  (with-open-file (out filename
		       :direction :output
		       :if-exists :supersede)
    (with-standard-io-syntax
	(print *db* out))))

;; 保存数据到/etc/hosts
(defun save-db-to-hosts()
  (with-open-file (out "~/hosts"
		       :direction :output
		       :if-exists :supersede)
    (with-standard-io-syntax
	(dolist (var *db*)
	  (format out "~a~10t~a~%" (getf var :IP) (getf var :HOST-NAME))))))