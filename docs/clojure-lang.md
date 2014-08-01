
# clojure overview

[cheatsheet](http://clojure.org/cheatsheet)

## basic syntax

see also: http://clojure.org/reader

| Expression | Meaning |
|------------|---------|
| `{}`           | map
| `#{}`          | set
| `()`           | list
| `[]`           | vector
| `'`            | quote an expression to prevent evaluation
| `#()`          | lambda expression
| `\c`           | single character
| `"str"`        | string
| `#"re"`        | regular expression
| `@NAME`        | dereference a delay NAME. this is called the "wormhole" operator.

| Expression | Meaning |
|------------|---------|
| `(fn [VAR1 VAR2 ...] BODY)`         | create function
| `(let [VAR1 VAL1 ...] BODY)`        | locally define symbol-value mappings
| `(def VAR VAL)`                     | globally define symbol-value mappings
| `(defn NAME [VAR1 VAR2 ...] BODY)`  | globally define a named function
| `(for ...)`                         | list comprehension
| `(if TEST THEN ELSE)`               | two-part conditional evaluation
| `(if-let [VAR TEST] THEN ELSE)`     | conditional evaluation with named condition
| `(cond (= u1 1) :v1 (= u2 2) :v2 :else :v3)`  | multi-part conditional evaluation
| `(case var :v1 "val1" :v2 "val2" "default")`  | case statements
| `(when TEST EXPR ...)`              | single-part conditional evaluation
| `(when-let [VAR TEST] EXPR ...)`    | single-part conditional evaluation with named condition

Build list comprehensions using the for special form:
```
(for [BINDINGS] BODY)
```
where BINDINGS is one or more variable-value pair. The BODY is evaluated once for each combination of bindings, so that
```
=> (for [x [1 2 3] y [:a :b]] [x y])
([1 :a] [1 :b] [2 :a] [2 :b] [3 :a] [3 :b])
```
Use `:while` to specify stopping conditions, and `:when` to filter elements.

Expressions can be written in a somewhat imperative style using the "threading" special forms. For example, expressions such as
```
(reduce + (filter odd? (range 10)))
```
can be rewritten as
```
(->> (range 10)
     (filter odd?)
     (reduce +))
```
to express the operations in order of evaluation. Similarly, the "chaining" pattern is often used in OOP:
```
myobj.func1()
     .func2()
     .func3()
```
In clojure, something similar is seen in functions that operate on sequences, such as
```
(assoc (assoc #{} :a :va) :b :vb)
```
which can be rewritten as
```
(-> #{} (assoc :a :va) (assoc :b :vb))
```

symbol, reference, value: symbol is the name of a thing, reference is the container of a thing, and value is the thing in that container? reference types include: ref, var, atom, ...

A var is printed as `#'NAME`

## data structures

`list` - non-contiguous memory stored as linear linked cells
```
=> (list 1 2 3)
=> '(1 2 3)
```

`vector` - contiguous block of cells. Note that a quoted vector is equivalent to
a vector of quoted elements. Lists and vectors are comparable.
```
=> [1 2 3]
=> (vector 1 2 3)
=> (vec '(1 2 3))
```

`set` - collection of unique elements
```
=> #{1 2 3}
=> (set [1 2 3])
```

`map` - collection of key/value pairs
```
=> {1 11, 2 22}
=> {:a 11, :b 22}
```

a clojure `seq` is an interface over a collection of elements, similar to java's
`Iterable`, or python's `__iter__`.

## declaring functions

Define a named function with zero or more arguments
```
(defn NAME [VAR1 VAR2 …] BODY)
```

Use different definitions depending on the number of arguments:
```
(defn NAME
([]		BODY0)
([x]		BODY1)
([x y]	BODY2))
```

Support a variable number of arguments:
```
(defn NAME [VAR1 VAR2 ... & extra-args] BODY)
```

Add a docstring:
```
(defn NAME DOCSTR [VAR1 VAR2 ...] BODY)
```
and use `(doc NAME)` to access it.

To declare a tail-recursive function, use a combination of loop and recur:
```
(defn factorial [n]
    (loop [cnt n acc 1]
        (if (zero? cnt)
             acc
           (recur (dec cnt) (* acc cnt))))))
```

## deferred evaluation

`delay` - wrap an expression to be evaluated later. result is computed at most once, due to caching.

`deref` - get the result of a delayed expression. see also the wormhole operator.

`future` - a delayed expression that runs in a new thread
```
(def x (future EXPR …))  ; define a new parallel computation
;; EXPR is evaluated on another thread
(deref x)  ; block on EXPR, and return the result
(deref x)  ; access the cached result
```

`promise` - a delay without an expression. result must be set explicitly before being dereferenced.
```
(def box (promise))  ; create an empty promise
(deliver box "contents of box")  ; put something in it
(deref box)  ; pull it back out again
```

`lazy-cat` -

`lazy-seq` -

## including code

There are three ways to include a library [link](http://blog.8thlight.com/colin-jones/2010/12/05/clojure-libs-and-namespaces-require-use-import-and-ns.html):

* `require` is like `import MOD`

  ```
  => (require 'clojure.string 'clojure.test)
  => (require '[clojure.string :as cs])
  => (require '(clojure string test))
  => (require '(clojure [string :as cs])
  ```

  Here, "as" renames the imported library.

* `use` is like `from MODULE import *`. takes the same arguments as require, plus the "exclude" and "only".

  ```
  => (use '[clojure.string :exclude [replace]])
  => (use '[clojure.string :only [reverse]])
  ```

  In general, use-only is best.
  When debugging, reload code with

  ```
  => (use 'lich.core :reload)
  ```

* `import` is for java libraries

  ```
  => (import 'java.util.Date)
  => (import '(java.util Date GregorianCalendar))
  ```

  After import, symbols are available without the package prefix.

* `ns` declares the file's namespace and includes necessary libraries

  ```
  => (ns com.yieldbot.myproject
       "Namespace docstring"
       (:use [clojure.string :only [split join]])
       (:require clojure.stacktrace [clojure.test :as test]))
  ```

Notice that arguments are *not* quoted in this case.

## java interop

* http://chasemerick.files.wordpress.com/2011/07/choosingtypeforms2.png
* protocols
* reify
* gen-class

[example using reflection](http://stackoverflow.com/questions/5821286/how-can-i-get-the-methods-of-a-java-class-from-clojure/5821658#5821658)
