# clojure reference

## core functions

| function | description |
|----------|-------------|
| apply | call function with args given by seq (rather than calling function with seq as single argument)
| assoc | add key/value to map
| concat | paste sequences
| conj | add element to beginning (list) or end (vector) of seq
| cons | add element to head of seq
| contains? | whether collection contains element. similarly, apply the set to the search term
|| => (#{1 2 3} 3) <br/> 3
| count | number of elements in collection
| cycle | repetitions of a sequence
| disj | set with element removed
| dissoc | map with key/value removed
| drop | remove first N elements of seq
| drop-last | remove last N elements of seq
| filter | yield elements of seq matching condition
| first | element by offset
| frequencies | number of occurrences of elements in a seq
| get | map value by key (supports default value). similarly, apply the map to the search key or vice versa
|| => ({:a 1 :b 2} :a) <br/> 1 <br/> => (:a {:a 1 :b 2}) <br/> 1
| group-by | group elements of a seq by some function
| interleave | take consecutive elements from each list. like a zip+join.
|| => (interleave [:a :b :c] [1 2 3]) <br/> (:a 1 :b 2 :c 3)
| interpose | insert a delimiter between elements of a seq
|| => (interpose :and [1 2 3]) <br/> (1 :and 2 :and 3)
| into | reduce elements into a collection ??
| iterate | apply function recursively, yielding results along the way
|| iterate f x -> f(x) f(f(x)) ...
| last | element by offset
| lazy-seq | like a generator/iterator -- see Lazy Evaluation
| map | apply function to sequence element-wise. map can take multiple sequences, zipping the sequences.
|| => (map + [1 2] [3 4]) <br/> (4 6)
| map-indexed | apply function to seq with element offset. like enumerate()
| merge | combine two or more maps
| nth | element by offset
| next | tail of collection, or nil on single-element input
| partition | group seq into sub-sequences
| partition-by | group seq based on condition
| pos? | test for positive number
| rand | generate pseudo-random number (between zero and one?)
| range | numbers in an interval
| reduce | iteratively apply function to first two elements of list, replacing them with the result
| reduce-kv | apply a reduction to a mapping
| reductions | like reduce, but yield partials. e.g., this can give cumulative sums
| remove | yield elements of seq not matching condition (complement of filter)
| repeat | infinite repetitions of value
| repeatedly | infinite application of function
|| repeatedly f -> f() f() ...
| rest | tail of collection, or empty list on single-element input
| reverse | get seq in reversed order
| second | element by offset
| select-keys | extract portion of a map
| shuffle | randomize order of seq
| split-at | break seq in two
| split-with | break seq in two, using a function to decide when to split
| take | yield first N elements of seq
| take-last | yield last N elements of seq
| take-while | yield elements until condition fails

## flambo api

basic functions in `flambo.api`

| function | description |
|----------|-------------|
| parallelize | scatter a collection across nodes
| text-file | read data from disk
| defsparkfn | create named function
| fn | create anonymous function
| map | apply parallel map
| reduce | apply parallel reduction
| collect | gather a collection
| take | gather the head of a collection

https://github.com/yieldbot/flambo

## code snippets

list files in a directory (recursively)
```
(file-seq (clojure.java.io/file "/path/to/directory"))
```

read lines of a text file (could be a URL)
```
(with-open [rdr (clojure.java.io/reader "/tmp/foo.txt")]
  (doall (line-seq rdr)))
```

write lines to a text file
```
(with-open [wrt (clojure.java.io/writer "tmp/foo.txt")]
  (doseq [line all-lines]
    (.write wrt line)))
```

raise an exception
```
(throw (Exception. "my message"))
```

http://nakkaya.com/2010/06/15/clojure-io-cookbook/
http://stackoverflow.com/questions/7756909/in-clojure-1-3-how-to-read-and-write-a-file

## debugging

```
(require 'clojure.tools.namespace.repl)
(clojure.tools.namespace.repl/refresh)
```

```
(require 'myorg.mypackage :reload)
```

```
(use 'clojure.tools.trace)
(trace expr)
(trace-vars myorg.mypackage/symbol)  ; also untrace-vars
```

```
(clojure.inspector/inspect seq_)  ; also inspect-tree and inspect-table
```

```
(defn pprint-str [x]
  (with-out-str (pprint x)))

(defmacro dbg [x]
  `(let [x# ~x]
     (printf "dbg %s:%s> %s is %s\n"
             ~*ns*
             ~(:line (meta &form))
             ~(pr-str x)
             (pprint-str x#))
     (flush)
     x#))

;; then call with
(dbg (f x))
```

```
(use 'spyscope.core)
#spy/d (+ 1 2 3)
```

for java reflection:
```
(require '[clojure.reflect :as r])
(r/reflect "foo")
```

http://stackoverflow.com/questions/5821286/how-can-i-get-the-methods-of-a-java-class-from-clojure/5821658#5821658

print the definition of a function:
```
(clojure.repl/source f)
```


## testing

```
(use 'midje.repl) (autotest)
```

## libraries

* core libraries

  * clojure.string
  * clojure.java.io
  * clojure.java.shell


* [midje](https://github.com/marick/Midje) - unit testing library for clojure

  * [lein-midje](https://github.com/marick/lein-midje) - leiningen integration. see `lein midje :autotest`
  * to automatically retest a set of files, use
  `(autotest :files "src/clj/lich" "test/lich/file1_test.clj")`


* pallet/thread-expr - extended threading macros

* [jackknife](https://github.com/sritchie/jackknife) - general-purpose clojure utilities. see also `slurm` (internal project)


## tooling

### leiningen

Project management is handled by Leiningen, which is like a combination of pip and fabric for clojure. Leiningen provides dependency management via Maven.

[tutorial](https://github.com/technomancy/leiningen/blob/master/doc/TUTORIAL.md)
