def add_two num
	if num.nil? or num.is_a? String
    throw ArgumentError
	else
	  num + 2
	end
end
begin
add_two nil
# exit
# rescue SystemExit
#   p "not today pal"
rescue ArgumentError => err
  puts "Wrong argument type"
  p err.class, err.backtrace
end