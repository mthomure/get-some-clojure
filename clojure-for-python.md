
# clojure for python programmers

N.B. Except where noted, all names refer to clojure data types. For example, a `list` would be clojure's linked-list datatype, rather than python's mutable array-like datatype. Also, we assume the following python preamble.

```
import itertools as it
from pandas import Series
```

# analogous data structures

## tuple

python has an immutable sequence called `tuple`, which is similar to clojure's `vector`. the `vector` is also clojure's closest analog to python's (mutable) `list`.

| Python                      | Clojure | Description
|-----------------------------|---------|------------
| tuple(1, 2, 3)              | (vector 1 2 3)  | create vector
| (1, 2, 3)                   | [1 2 3]  ||
| (1, 2) + (3, 4)             | (concat [1 2] [3 4])  | combine vectors
| tuple(seq_)                 | (vec seq_)  | construct a vector from some other sequence
| vec_[0]                     | (first vec_)  | access first element
| vec_[key]                   | (get vec_ key)  | access arbitrary element
|                             | (vec_ key)  | (using vector as a function to perform a lookup)
| vec_[1:]                    | (rest vec_)  | all but first element
| vec_ + (3,)                 | (conj vec_ 3)  | append to tail of vector
| el in vec_                  | ??  | linear search of vector
| len vec_                    | (count vec_)  | number of elements
|                             | drop  ||
|                             | drop-last  ||

## generator

python supports (possibly-infinite) sequences created using generators. clojure has an immutable sequence called `list`, which is backed by a singly-linked list. this list can be created "lazily", and a lazy sequence is analogous to a python generator.

| Python                      | Clojure | Description
|-----------------------------|---------|------------
|                             | (list 1 2 3)  | create list
|                             | (1 2 3)  ||
|                             | (count it_)  | count elements (in linear time!)
| list(it_)                   | (doall it_)  | force evaluation of lazy list

however, note that a lazy sequence is caching! as a result, the following expressions

```
(doall it_)
(first it_)
(first it_)
```

result in the same values for both uses of the `first` function. this is contrasted with python's "one use" generators, which leave caching to the user.

## dict

python has a (mutable) mapping called `dict`, which is similar to clojure's (immutable) mapping.

| Python                      | Clojure | Description
|-----------------------------|---------|------------
| {'a':1, 'b':2}              | {:a 1 :b 2}  | create a set
| dict([[1,11], [2,22]])      | (into {} [[1 11] [2 22]])  | create mapping from sequence of (key,value) pairs
| dict_[key]                  | (get dict_ key)  | access value by key
|                             | (dict_ key)  | (use mapping as function) |
|                             | (key dict_)  | (use key as function) |
| dict_[key] = value          | (assoc dict_ key value)  | create new mapping with an additional key
| dict_.pop(key)              | (dissoc dict_ key)  | create new mapping that lacks the given key
| key in dict_                | (contains? dict_ key)  | check for key in mapping
| len dict_                   | (count dict_)  | number of keys
| dict_.items()               | (seq dict_) | (key,value) pairs
| dict_.keys()                | (keys dict_) | just the keys
| dict_.values()              | (vals dict_) | just the values

## set

python and clojure both have a `set` data structure.

| Python                      | Clojure | Description
|-----------------------------|---------|------------
| {1, 2}                      | #{1 2 3}  | create
| set(seq_)                   | (set seq_)  | convert sequence to set
| {1, 2} - {1}                | (disj #{1 2} 1)  | new set with element removed
| el in set_                  | (contains? set_ el)  | search for element
|                             | (set_ el)  | (search, but return el if found, else nil)

## iterables

python has operations that apply to the general class of iterables (called "sequences" in clojure), which is true in clojure as well.

| Python                      | Clojure | Description
|-----------------------------|---------|------------
| it.cycle(seq_)              | (cycle seq_)  | infinite copies of sequence, concatenated together into list
| len seq_                    | (count seq_)  | number of elements
| filter(func, seq_)          | (filter func seq_)  | use function to select sub-sequence
| any(seq_)                   | (some identity seq_) | detect if any elements are truthy
| all(seq_)                   | (every? identity seq_) | check if all elements are truthy
| zip(seq1, seq2)             | (map vector seq1 seq2) | combine corresponding elements from two lists

## ipython

| Python                      | Clojure | Description
|-----------------------------|---------|------------
| func_?                      | (doc func_)  | lookup documentation for function
| func_??                     | (source func_)  | lookup definition for function
| reload(module)              | (require 'module :reload)  | update module from source

## miscellaneous

| Python                      | Clojure | Description
|-----------------------------|---------|------------
| `"%d %s" % (a, b)`          | (format "%d %s" a b) | convert values to formatted string
| pprint.pprint(x)            | (pprint x)  | pretty print a value
| def f(x): return x+1        | (defn f [x] (x+1))  | define named function
| lambda x: x+1               | (fn [x] (x+1))  | define anonymous function
| f(*xs)                      | (apply f xs)  | call function, binding arguments to elements of a sequence
| import mylib                | (require 'mylib)  | import module name into namespace
| from mylib import *         | (use 'mylib)  | import all symbols in module into namespace
| np.rand()                   | (rand)  | single random number between zero and one
| Series(seq_).value_counts() | (frequencies seq_)  | count occurrence of each unique value
| Series(seq_).groupby(key)   | (group-by seq_ key)  | get sub-lists by element
