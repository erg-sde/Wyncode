for i in 1..25
	if i.odd?
	  puts "The square root of #{i} equals #{Math.sqrt(i)}"
  end
end

def element_index element, my_array
  for i in my_array
    if element == i
      return my_array.index(element)
    end
  end
  -1
end