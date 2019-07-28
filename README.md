# genasent

Generates a list of all possible sentences for a given CFG (context-free grammar).
The CFG is to be specified in a form of a list of BNF rules:
~~~
S -> E
E -> T '+' E | T
T -> F '*' T | F
F -> 'a' | 'b' | '(' E ')'
~~~

~~~lisp
'((S (E))
  (E (T "+" E) (T))
  (T (F "*" T) (F))
  (F ("a") ("b") ("(" E ")")))
~~~

The depth of recursive rules expansion may be specified with setting gobal variable ```lisp *recursive-depth*```


# Usage example

~~~lisp
GENASENT> (let ((*recursive-depth* 1))
	    (generate-all-sentences-by-cfg
	     'S '((S (E))
		  (E (T "+" E) (T))
		  (T (F "*" T) (F))
		  (F ("a") ("b") ("(" E ")")))))
("a*a+a*a" "a*a+a*b" "a*a+b*a" "a*a+b*b" "a*a+a" "a*a+b" "a*b+a*a" "a*b+a*b"
 "a*b+b*a" "a*b+b*b" "a*b+a" "a*b+b" "b*a+a*a" "b*a+a*b" "b*a+b*a" "b*a+b*b"
 "b*a+a" "b*a+b" "b*b+a*a" "b*b+a*b" "b*b+b*a" "b*b+b*b" "b*b+a" "b*b+b"
 "(a)*a+a*a" "(a)*a+a*b" "(a)*a+b*a" "(a)*a+b*b" "(a)*a+a" "(a)*a+b"
 "(a)*b+a*a" "(a)*b+a*b" "(a)*b+b*a" "(a)*b+b*b" "(a)*b+a" "(a)*b+b"
 "(b)*a+a*a" "(b)*a+a*b" "(b)*a+b*a" "(b)*a+b*b" "(b)*a+a" "(b)*a+b"
 "(b)*b+a*a" "(b)*b+a*b" "(b)*b+b*a" "(b)*b+b*b" "(b)*b+a" "(b)*b+b" "a+a*a"
 "a+a*b" "a+b*a" "a+b*b" "a+a" "a+b" "b+a*a" "b+a*b" "b+b*a" "b+b*b" "b+a"
 "b+b" "(a)+a*a" "(a)+a*b" "(a)+b*a" "(a)+b*b" "(a)+a" "(a)+b" "(b)+a*a"
 "(b)+a*b" "(b)+b*a" "(b)+b*b" "(b)+a" "(b)+b" "a*a" "a*b" "b*a" "b*b" "(a)*a"
 "(a)*b" "(b)*a" "(b)*b" "a" "b" "(a)" "(b)")
 ~~~