class ReplGame < Hash
  srand(number=Random.new_seed)
  @@errtxt = "I'm not sure what you mean, but you don't have much time to waste."
  @@greeting = %(You awaken deep in a dark dungeon. A white rat wearing a wizard hat scurries over and 
  greets you: 'You're finally awake! What's your name, if you don't mind me asking?')
  @@newroom = %(You stumble into a dimly lit corridor. The air is damp and smells musty.)
  @@dragontext = %(Your jaw drops open as a massive, scaled beast rears its head. Before you have a moment to react, you're engulfed in flames.)
  @@badluck = %(You attempt to run and find yourself in a strange new corridor. You're wounded, and it doesn't look good for you. You search your bags for a health potion, but then remember this game doesn't have those.
  As you think your luck can't get any worse, you turn around and... )
  @@gameovertext = %(
    G         O.        :[
      A         V.      :[
        M         E.    :[
          E         R.  :[
    )

  @@attacktext = %(You can:
  -Throw a (ro)ck
  -Try to (ru)n
  -Lay down and (di)e
  )

  @@acttext = %(You can:
  -Move (f)orward
  -Search (d)eeper for treasure
  -Try and get some (r)est.
  )

  @@treasuretext = %(You see a treasure chest at the end of a long hallway. You begin to pick
  up the pace as you walk closer. Sure enough, you've found yourself a nice, big treasure chest.
  As you try to open it up, you...
  Wake up. In class. At wyncode. Ed is saying something about arrays not being hashes but also
  being hashes... Dammit.
  )
  def initialize
    super
    self.get_name
    self.get_roomstate
  end

  def get_health
    self[:health] ||= 10
    if @monster_attack
      self[:health] -= 2
    end
    if self[:health] <= 0
      self.game_over
    else
      @healthbar = "#{self[:name]}: [" 
      @healthbar << "<3" * (self[:health]) << "-" * (10 - self[:health]) << "]"
    end
  end

  def get_name
    puts @@greeting
    self[:name] = gets.chomp.capitalize
    puts "Well then #{self[:name]}, I wish you well on your journey through this dangerous corridor. Good luck to you."
    puts "The white rat disappears in a puff of smoke."
  end

  def get_roomstate
    self.get_health
    @roomcount ||= 0
    @roomstate ||= 0
    unless @monsterenc
      @roomstate = rand(1..100)
      @roomcount += 1
      if @roomcount > 3
        @roomstate *= Math.log(@roomcount)
      end
      puts @@newroom
      case @roomstate
      when 1..45
        puts "You hear something move in the darkness. A monster approaches."
        self.monster_enc
      when 46..90
        puts "After walking for some time, you stumble upon a doorway in the darkness. You pass through it."
        self.get_player_act
      when 91..100
        if @roomcount > 3
          puts %(As you begin to explore, you see something shiny 
            in the distance. You begin walking toward it and pass through a doorway.)
          self.get_treasure
        else
          puts %(The room is labyrinthine and you easily get lost wandering its paths. Somehow you end up where you started.)
          self.get_player_act
        end
      end
    else
      self.get_player_attack
    end
  end

  def monster_enc
    unless @monsterenc
      self.get_monster
      if @monster == "dragon"
        puts %(You hear a low rumbling and turn around. You see eyes 
        in the darkness and prepare to run.)
        self.game_over
      else
        @monsterenc = true
        self.get_player_attack
      end
    end
  end

  def get_monster
    @monster = rand(0..100)
    case @monster
    when 0..45
      @monster = "rat"
      puts "You're startled by a sickly looking rat."
    when 46..85
      @monster = "rabid dog"
      puts "A fierce looking dog approaches, baring its teeth."
      self.get_dogstate
    when 86..100
      if @roomcount > 3
        @monster = "dragon"
      else
        @monster = "rabid dog"
        puts "A fierce looking dog approaches, baring its teeth."
        self.get_dogstate
      end
    end
  end

  def get_monsteract
    if @monster == "rabid dog"
      puts "The dog snarls and jumps toward you"
      @dogbite = rand(0..50)
      case @dogbite
      when 0..35
        puts "The dog sinks his teeth into you and you desperately push him off"
        @monster_attack = true
        self.get_health
        self.get_player_attack
      when 36..50
        puts "You dodge the dog's lunge like some sort of ninja. Impressive."
        @monster_attack = false
        self.get_player_attack
      end
    else
      "The rat hisses at you. It's disgusting."
      self.get_player_attack
    end
  end

  def game_over
    puts @@badluck
    puts @@dragontext
    puts @@gameovertext
  end

  def get_player_attack
    puts "This doesn't look good. What do you want to do?"
    puts @@attacktext
    puts @healthbar
    if @monster == "rabid dog"
      puts "RABID DOG: #{@doghealthbar}"
    end
    @playerattack = gets.chomp.downcase
    case @playerattack
    when "rock", "ro"
      if @monster == "rabid dog"
        @playeratk = true
        puts "You throw a rock at the dog. It wimpers in pain. Hope you're proud of yourself."
        self.get_dogstate
        self.get_roomstate
      else
        puts "The rat scurries away."
        @monsterenc = false
        self.get_roomstate
      end
    when "run", "ru"
      @trying = rand(0..50)
      case @trying
      when 0..40
        if @monster == "rabid dog"
          puts "You almost feel the dog's breath on your neck as you run, but suddenly he seems to be distracted. He stops chasing."
        else
          puts "You run in fear. From the rat. Nice."
        end
        @monsterenc = false
        self.get_roomstate
      when 41..50
        self.game_over
      end
    when "die", "di"
      self.game_over
    else
      puts @@errtxt
      self.get_player_attack
    end
  end

  def get_dogstate
    @doghealth ||= 2
    if @playeratk
      @doghealth -= 1
      if @doghealth <= 0
        puts "The dog runs off with its tail between its legs. Well done."
        @doghealth = nil
        @monsterenc = false
      end
      @playeratk = false
    end
    if @doghealth
      @monsterenc = true
      @doghealthbar = "["
      @doghealthbar << ("<3" * @doghealth) << ("-" * (2-@doghealth)) << "]"
    end
  end

  def get_player_act
    puts @@acttext
    puts @healthbar
    @playeract = gets.chomp.downcase
    case @playeract
    when "forward", "f"
      puts "You move forward, deeper into the darkness. You see a doorway and go through it."
      self.get_roomstate
    when "deeper", "d"
      @treasureroll = rand(0..100)
      case @treasureroll
      when 80..100
        puts "As you search through the room, you find a doorway leading into another room. You go in."
        self.get_treasure
      else
        @monster = "rabid dog"
        @monsterenc = true
        puts "While you're rummaging about, a scary looking dog approaches. As you turn around, he jumps at you!"
        self.get_roomstate
      end
    when "rest", "r"
      self.game_over
    else
      puts @@errtxt
      self.get_player_act
    end
  end

  def get_treasure
    puts @@treasuretext
  end
end
ReplGame.new
