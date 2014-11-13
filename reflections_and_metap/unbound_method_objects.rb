class Array
  def my_own_arr_operation(arr2)
    "Yippee!! - #{self}.my_own_arr_operation(#{arr2}) is called"
  end
end

#First create an object of unbounded method
um = Array.instance_method(:my_own_arr_operation)

#Then bind it to the object which will invoke the above method
binded_object = um.bind([1,2])

#Call the method & pass the parameters, if any
result = binded_object.call([3,4])
puts result