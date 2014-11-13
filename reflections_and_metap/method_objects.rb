#Ruby methods are instance of Method class
#Invoking a method through Method object is less efficient than invoking it directly

#Object class defines a method names as "method"
#  Pass it a method name, as a string or as a symbol & it returns a
#  Method object representing the named method, or else it throws "NameError".
[1,2].method("join") #it will return Method object as #<Method: Array#join>

#You can invoke above thing by using "call", so it will execute that method
[1,2].method("join").call #it's equivalent to [1,2].join()
[1,2].method("concat").arity => #It will return the number of parameters the method takes i.e 1

#From Ruby 1.9, Method class also defines following 3 methods
[1,2].method("join").name => "join"
[1,2].method("join").owner => Array
[1,2].method("join").receiver => Array