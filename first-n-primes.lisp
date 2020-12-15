;; SBCL v2.0.10
;;
;; $ time sbcl --script first-n-primes.lisp 100000
;; real	0m0.771s
;; user	0m0.681s
;; sys	0m0.050s
;;
;; $ time sbcl --script first-n-primes.lisp 1000000
;; real	0m23.121s
;; user	0m21.583s
;; sys	0m0.419s
;;
;; $ time sbcl --script first-n-primes.lisp 1000000 > /dev/null
;; real	0m21.864s
;; user	0m21.469s
;; sys	0m0.087s


;;;; shorter alias for get-output-stream-string
(setf (fdefinition 'goss) #'get-output-stream-string)


;;;; is-prime iterations (recursive impl.):
;; (defun is-prime--iterate (n &optional (i 5))
;;   (cond
;;     ((< n (* i i)) t)
;;     ((zerop (mod n i)) nil)
;;     ((zerop (mod n (+ 2 i))) nil)
;;     (t (is-prime--iterate n (+ 6 i)))))


;;;; is-prime iterations (non-recursive impl.):
(defun is-prime--iterate (n)
  (do ((i 5 (+ 6 i)))
      ((< n (* i i)) t)
    (cond ((zerop (mod n i)) (return))
          ((zerop (mod n (+ 2 i))) (return)))))


;;;; we wo'nt need is-prime edge conditions, use is-prime--iterate directly:
(setf (fdefinition 'is-prime) #'is-prime--iterate)

;; (defun is-prime (n)
;;  (cond ((< n 4) (> n 1))
;;        ((zerop (mod n 2)) nil)
;;        ((zerop (mod n 3)) nil)
;;        (t (is-prime--iterate n))))


(defun println (dest str)
  (write-string str dest)
  (write-char #\linefeed dest))


(defun first-n-primes (cnt)
  (let ((out (make-string-output-stream)))
    (when (<= 0 (decf cnt)) (println out "2"))
    (when (<= 0 (decf cnt)) (println out "3"))
    (when (<= cnt 0) (return-from first-n-primes (goss out)))

    (do ((i 5 (+ 6 i))) (nil)
      (when (is-prime i)
        (println out (write-to-string i))
        (and (zerop (decf cnt)) (return (goss out))))
      (when (is-prime (+ 2 i))
        (println out (write-to-string (+ 2 i)))
        (and (zerop (decf cnt)) (return (goss out)))))))


(let (cnt primes)
  (setq cnt (second sb-ext:*posix-argv*))
  (setq cnt (parse-integer cnt))
  (setq primes (first-n-primes cnt))
  (princ primes))
