def max_find *nums
  nums.delete_if { |i| i < nums.sort.[](-1) }
  return nums
end

i = max_find 1, 2, 3, 4, 5, 6
p i

# def max_test *test_args
#   test_nums = []
#   p test_args
#   test_args.each_index do |i|
#     test_nums << test_args[i].to_f
#   end
#   p test_nums
#   p max_find test_nums
# end

def capitalize_each names
  names.map(&:capitalize)
end

names = ['romeo', 'oedipus', 'hansel', 'gretel']
names = capitalize_each(names)
p names