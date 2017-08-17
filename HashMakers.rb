class HashMakers < Hash
  def champs_maker
    10.times do |i|
      i = gets.chomp.split(" - ")
      year = i[0].to_i
      team = i[1]
      self[year] = team
    end
  end

  def author_set books
    books.each do |book, author|
      author = gets.chomp
      self[book] = author
    end
  end

  
  end
end