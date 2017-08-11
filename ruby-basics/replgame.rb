class ReplGame < Hash
  srand(number=Random.new_seed)
  @@errtxt = "I'm not sure what you mean, but you don't have much time to waste."
  @@greeting = %(You awaken deep in a dark dungeon. A white rat with a wizard hat scurries over and 
  greets you: 'You're finally awake! What's your name, if you don't mind me asking?')
  @@newroom = %(You stumble into a dimly lit corridor. The air is damp and smells musty.)
  @@dragontext = %(Your jaw drops open as you enter the room and a massive, scaled beast 
  rears its head. 

  Before you have a moment to react, you're engulfed in flames.)
  @@badluck = %(You attempt to run and find yourself in a strange new corridor. You're wounded, 
    and it doesn't look good for you. You search your bags for a health potion, but 
    then remember this game doesn't have those.

    As you think your luck can't get any worse, you turn around and... )
  @@gameovertext = %(
    G        O.     :[
      A       V.    :[
        M      E.   :[
          E     R.  :[
    )

  @@attacktext = %(You can:
  -Throw a (rock)
  -Try to (run)
  -Lay down and (die)
  )

  @@acttext = %(You can:
  -Move (forward)
  -Search (deeper) for treasure
  -Try and get some (rest).
  )

  @@treasuretext = %(You see a treasure chest at the end of a long hallway. You begin to pick
    up the pace as you walk closer. Sure enough, you've found yourself a nice, big treasure chest.
    As you try to open it up, you...


    Wake up. In class. At wyncode. Ed is saying something about arrays not being hashes but also
    being hashes... Dammit.
  )
  def initialize
    super
    self.get_health
    self.get_name
    self.get_roomstate
  end

  def get_health
    self[:health] ||= 100
    if @monster_attack
      self[:health] -= 20
    end
    if self[:health] <= 0
      self.game_over
    end
  end

  def get_name
    puts @@greeting
    self[:name] = gets.chomp.capitalize
    puts "Well then #{self[:name]}, I wish you well on your journey through this dangerous corridor. Good luck to you."
  end

  def get_roomstate
    @roomcount ||= 0
    @roomstate = rand(1..100)
    @roomcount += 1
    if @roomcount > 3
      @roomstate *= @roomcount
    end
    puts @@newroom
    case @roomstate
    when 0..45
      self.monster_enc
    when 46..90
      self.get_player_act
    when 91..100
      self.get_treasure
    end
  end

  def monster_enc
    self.get_monster
    if @monster == "dragon"
      self.game_over
    else
      self.get_monsteract
    end
    self.get_roomstate
  end

  def get_monster
    @monster = rand(0..100)
    case @monster
    when 0..45
      @monster = "rat"
      puts "You're startled by a sickly looking rat. What will you do?"
      self.get_player_attack
    when 46..85
      @monster = "rabid dog"
      puts "A fierce looking dog approaches, baring its teeth"
      self.get_player_attack
    when 86..100
      @monster = "dragon"
    end
  end

  def get_monsteract
    case @monster
    when "rat"
      puts "The rat scurries away."
    when "rabid dog"
      puts "The dog snarls and jumps toward you"
      @dogbite = rand(0..50)
      case @dogbite
      when 0..35
        puts "The dog sinks his teeth into you and you desperately push him off"
        @monster_attack = true
      when 36..50
        puts "You dodge the dog's lunge like some sort of ninja. Impressive."
        @monster_attack = false
      end
      self.get_health
    end
  end

  def game_over
    puts @@badluck
    puts @@dragontext
    puts @@gameovertext
  end

  def get_player_attack
    puts "What do you want to do?"
    puts @@attacktext
    @playeratk = gets.chomp.downcase
    case @playeratk
    when "rock" || "ro"
      self.get_dogstate
      @doghealth -= 1
    when "run" || "ru"
      @trying = rand(0..50)
      case @trying
      when 0..40
        puts "You almost feel the dog's breath on your neck as you run, but suddenly he seems to be distracted. He stops chasing."
        self.get_roomstate
      when 41..50
        self.game_over
      end
    when "die" || "di"
      self.game_over
    else
      puts @@errtxt
      self.get_player_attack
    end
  end

  def get_dogstate
    @doghealth ||= 4
    if @doghealth == 0
      puts "The dog runs off with its tail between its legs. Well done."
      self.get_roomstate
    end
  end

  def get_player_act
    puts @@acttext
    @playeract = gets.chomp.downcase
    case @playeract
    when "forward"
      self.get_roomstate
    when "deeper"
      @treasureroll = rand(0..100)
      case @treasureroll
      when 0..80
        puts "As you search through the room, you find a doorway leading into another room. You go in."
        self.get_treasure
      else
        @monster = "rabid dog"
        self.get_monsteract
      end
    when "rest"
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

init = ReplGame.new
