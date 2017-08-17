def puts_block
  yield
end

puts_block do
  puts "hi"
end

