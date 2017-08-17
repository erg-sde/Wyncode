
def menu_maker menu
  menu = Hash.new
  menu[:sections] = Array.new
  p "How many sections?"
  n = gets.chomp.to_i
  n.times do |i, sectname|
    puts "#{i + 1} section name?"
    sectname = gets.chomp
    menu[:sections] << {:name => "#{sectname}"}
  end
  menu[:sections].each_index do |i|
    p menu[:sections][i], "How many items?"
    menu[:sections][i][:items] = []
    o = gets.chomp.to_i
    o.times do |j, name, desc, pr|
      puts "Dish #{j+1} info?"
      name = gets.chomp
      desc = gets.chomp
      pr = gets.chomp.to_f
      self[:sections][i][:items] << {:name => "#{name}", :description => "#{desc}", :price => pr}
    end
  end
end