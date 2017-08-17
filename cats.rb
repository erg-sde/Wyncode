def cathatter
  cats = Array.new(100, true)
  cats.each_index do |i|
    cats.each_index do |j|
      if (i + 1) % (j+1) == 0
        cats[i] = !cats[i]
      end
    end
  end
  puts cats
  cats
end


cat_holder = cathatter
truecount = ""
falsecount = ""
cat_holder.each_index do |i|
  if cat_holder[i]
    truecount << "#{i}" << ", "
  else 
    falsecount << "#{i}" << ", "
  end
end
puts truecount
puts falsecount