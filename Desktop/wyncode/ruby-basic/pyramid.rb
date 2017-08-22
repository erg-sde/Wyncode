height = ARGV[0].to_i
output = ""
height.times do |i|
  spacer = height - (i+1).to_i
  pyr = 2 * (i+1)
  output << " " * spacer
  output << "*" * pyr
  output << " " * spacer
  output << "\n"
end
puts output