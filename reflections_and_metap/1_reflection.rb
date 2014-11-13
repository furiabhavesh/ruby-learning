#Reflection, also called as "introspection" - Its like standing in front of mirror and asking, "How do I look ?" :)
#It means that a program can examine its state and its structure
#Eg : We can know what all methods exists in a Class, know the value of instance variable of an object

"my_object".class #Returns the class of an object

String.superclass #Returns the superclass of a Class

"my_object".instance_of?(String) #Determines whether the object is an instance of specified Class

"my_object".respond_to?(:len) #Determines whether the string object has a method called "len"