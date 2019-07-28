(uiop:define-package :generate-all-sentences
    (:nicknames :genasent)
  (:use :cl :anaphora)
  (:export #:generate-all-sentences-by-cfg
	   #:*recursive-depth*))

(in-package :genasent)


(defun str+list->list (str list)
  (mapcar (lambda (car) (format nil "~a~a" str car))
	  list))

(defgeneric conc-to-next-a-s (symbol next-a-s))

(defvar *recursive-depth* 0)

(defvar *rules* nil)
(defvar *visited-stack* nil)
(defun g-a-s-for-rule (entry)
  (let ((current-depth (aif (member entry *visited-stack*
				    :test #'eq :key #'first)
			    (1+ (second (first it)))
			    0)))
    (unless (> current-depth *recursive-depth*)
      (let ((*visited-stack* (cons (list entry current-depth)
				   *visited-stack*)))
	(mapcan (lambda (branch)
		  (reduce #'conc-to-next-a-s branch
			  :from-end t
			  :initial-value (list "")))
		(gethash entry *rules*))))))

(defmethod conc-to-next-a-s ((entry symbol) next-a-s)
  (mapcan (lambda (a-s) (str+list->list a-s next-a-s))
	  (g-a-s-for-rule entry)))

(defmethod conc-to-next-a-s ((entry string) next-a-s)
  (str+list->list entry next-a-s))

(defgeneric generate-all-sentences-by-cfg (entry cfg)
  (:method ((entry symbol) (cfg list))
    (let ((*rules* (make-hash-table :test 'eq)))
      (dolist (rule cfg)
	(if (gethash (first rule) *rules*)
	    (error "RULE REDECLARATION")
	    (setf (gethash (first rule) *rules*)
		  (rest rule))))
      (g-a-s-for-rule entry))))
