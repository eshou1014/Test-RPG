require 'pry'
require 'asciiart'
#Create town class with an array of ASCII art

class Character
  attr_reader :attack, :lose_hp, :weapons
  attr_accessor :name, :type, :hp, :chosen_weapon, :dead

  def initialize(args = {})
    @name = name
    @type = @type
    @hp = hp
    @weapons = ["axe", "spear", "polearm"]
    @chosen_weapon = []
    @attack = 0
    @dead = false
  end

  def weapon
    axe = AsciiArt.new("/Users/EricShou/Desktop/Game/axe.jpg")
    spear = AsciiArt.new("/Users/EricShou/Desktop/Game/spear.jpg")
    polearm = AsciiArt.new("/Users/EricShou/Desktop/Game/polearm.jpg")
    puts "Axe class: HP = 20, Attack = 5   Spear class: HP = 15, Attack = 8      Polearm Class: HP = 10 , Attack = 10"
    choice = gets.chomp
    weapons.detect do |k,v|
      if choice == "axe" || choice == "Axe"
        axe.image_chars=axe.image_chars.reverse
        puts axe.to_ascii_art(color: true, width: 80)
        @chosen_weapon << choice
        @hp = 20
        @attack = 5

      elsif choice == "spear" || choice == "Spear"
        spear.image_chars=spear.image_chars.reverse
        puts spear .to_ascii_art(color: true, width: 50)
        @chosen_weapon << choice
        @hp = 15
        @attack = 8
      elsif choice == "polearm" || choice == "Polearm"
        polearm.image_chars=polearm.image_chars.reverse
        puts polearm.to_ascii_art(color: true, width: 75)
        @chosen_weapon << choice
        @hp = 30
        @attack = 10

      else
        puts " "
        puts "That is not a class from the list."
        puts "Please choose a real class."
        weapon
        end
      end
  end

  def lose_hp
    @hp -= 5
  end

  def died
    lose = AsciiArt.new("/Users/EricShou/Desktop/Game/lose.jpg")

    if @hp == 0 || @hp < 0
      lose.image_chars=lose.image_chars.reverse
      puts lose.to_ascii_art(color: true, width: 80)
      abort("You have been killed. You lose.")
    else
      puts "You're still alive."
      puts "--------------------"
    end
  end

end

class Zino
  attr_reader :target_status_alive, :player_hit, :lose_hp
  attr_accessor :hp

  def initialize
    @target_status_alive = true
    @player_hit = false
    @hp = 30
  end

  def died
    win = AsciiArt.new("/Users/EricShou/Desktop/Game/win.jpg")
    if @hp == 0 || @hp < 0
      win.image_chars=win.image_chars.reverse
      puts win.to_ascii_art(color: true, width: 75)
      abort("You have killed the Overlord!. You win!.")
    else
      puts "He's still alive."
      puts "--------------------"
      puts ""
    end
  end
end

class CreateGame
  attr_reader :character, :boss
  attr_accessor :user_input

  def initialize(args = {})
    @user_input = user_input
    @character = args[:character]
    @boss = args[:boss]
    @battle_commands = ["Dodge right!", "Dodge left!", "Dodge Up!", "Dodge Down!", "Swing right!", "Swing left!", "Swing Up!", "Swing Down!"]
  end

  def intro
    puts "Welcome to Revenge of the Zino"
    puts "---------------------------"
    puts ""
  end

  def player_intro
    puts "CHARACTER SETUP"
    puts "---------------"
    puts "Please write your name."
    input = gets.chomp
    @character.name = input
    puts " "
    puts "Please choose your weapon. Type the weapon you want in the console."
    @character.weapon
    puts ""
    puts "Your weapon is #{character.chosen_weapon}"
    @character.chosen_weapon
    puts "Your character HP is #{character.hp}"
    puts "Your name is #{character.name}."
    puts ""
    sleep(2)

  end

  def player_start
    puts "Type (Continue) to fight Zino now or (Explore) to go around the town"
    puts "You can gain more stats by exploring if you do not wish to fight with your current stats."
    user_input = gets.chomp
    if user_input == "Continue" || user_input == "continue"
      game_description
    elsif user_input == "Explore" || user_input == "explore"
      town
    else
      puts "Please type (Continue) or (Explore) into the console."
      player_start
    end
  end

   #Still need to finish town functionality
  def town
    town = AsciiArt.new("/Users/EricShou/Desktop/Game/town.jpg")
    town.image_chars=town.image_chars.reverse
    puts town.to_ascii_art(color: true, width: 75)
    puts "Welcome to Town DBC!"
    puts ""
    puts "There are many areas to explore! Type in wherever you want to go!"
    puts "Or if you are satisfied and want to Fight. Type (Continue)"
    puts "       Marketplace        "
    user_input = gets.chomp
    if user_input == "Marketplace" || user_input == "marketplace"
      market
    elsif user_input == "Continue" || user_input == "continue"
      puts ""
      game_description
    else
      puts "Please enter an area you wish to go to."
      town
    end
  end

  def market
    marketplace = AsciiArt.new("/Users/EricShou/Desktop/Game/market.jpg")
    marketplace.image_chars=marketplace.image_chars.reverse
    puts marketplace.to_ascii_art(color: true, width: 75)
    fisherman_answer = "join"
    # counter = 0
    guesses = 3
    puts "Welcome to the Market."
    puts "Fisherman: Hey there!"
    sleep(1)
    puts "Want to have some fish today? We're having a promotion."
    sleep(1)
    puts "If you can answer my question in 3 guesses, you can have this fish!"
    puts ""
    sleep(1)
    puts "What is the Array method that allows you to connect array elements into a string?"
    while guesses > 0
      user_input = gets.chomp
      if user_input == fisherman_answer || user_input == fisherman_answer.capitalize
        puts "You got it right!"
        puts ""
        puts "You eat the fish."
        sleep(3)
        puts "Character HP + 5"
        @character.hp += 5
        sleep(2)
        puts "Your HP is now #{@character.hp}"
        @character.hp
        puts ""
        puts "Fisherman: Now that was fun! And you learned something hopefully!"
        sleep(2)
        puts "Fisherman: See you later!"
        puts ""
        puts "You explored the Market. Where would you like to go now?"
        puts "     Town     "
        choice = gets.chomp
          if choice == "Town" || choice == "town"
            town
          end
      else
        puts "Fisherman: Sorry that's wrong!"
        guesses -= 1
      end

      if guesses <= 0
        puts "That's all you get!"
        puts "You explored the Market. Where would you like to go now?"
        puts "     Town     "
        market_out = gets.chomp
          if market_out == "Town" || market_out == "town"
            town
          end
     end
   end
  end

  def game_description
    zino = AsciiArt.new("/Users/EricShou/Desktop/Game/Zino.jpg")
    puts "GAME INTRO"
    puts "----------"
    puts "#{@character.name} you are about to embark on a dangerous mission."
    puts "You must defeat the Overlord Zino with your current stats."
    sleep(6)
    zino.image_chars=zino.image_chars.reverse
    puts zino.to_ascii_art(color: true, width: 80)
    puts "Would you like to travel to him now? To decide please type Yes or No"
    input = gets.chomp
    if input == 'yes' || input == 'Yes'
      puts "You have chosen to fight him now! Prepare for battle."
      puts ""
      sleep(2)

    elsif input == 'no' || input == 'No'
      puts "You are a coward! We shall ask you again in a few seconds."
      puts ""
      sleep(3)
      game_description
    end
  end

  def boss_description
      puts "Zino: AWAHHAHAAAAAAAAAAHHHH"
      puts ""
      sleep(1)
      puts "Zino: YOU DARE FIGHT ME?? TIME FOR YOU TO DIE"
      sleep(2)
      puts ""
      puts "You have encountered Zino."
      puts ""
      puts "Use the controls: W A S D to Dodge/Attack Zino"
      puts ""
      puts "W = Dodge/Swing up, A = Dodge/Swing left, S = Dodge/Swing down, D = Dodge/Swing right"
      puts ""
      puts "You must press one of these keys then ENTER to register your input."
      puts ""
      puts "The Battle will begin in 10 seconds"
      ""
      sleep(10)
      puts "Fight!"
  end

  def player_hp
    puts "Your hp is #{@character.hp}."
  end

  def boss_hp
    puts "Zino's hp is #{@boss.hp}."
  end

  def run
      boss_description

        while @user_input!="exit"
          "#{player_hp.to_s} : #{boss_hp.to_s}"
          @character.died
          puts ""
          @boss.died

          fight = @battle_commands[rand(0..7)]
          puts fight
          quick_time = select [ $stdin ], [], [], 2
            if quick_time.nil?
              puts "Zino dug his sword into you. Your hp is now #{@character.lose_hp}"
              puts ""
              @character.died
            elsif !quick_time.nil?
              @user_input = gets.chomp
            end



            if fight == @battle_commands[0]
                if @user_input == "d"
                  puts "You dodged the attack!"
                else
                  puts "You got hit!"
                  @character.lose_hp
                  puts "Your hp is #{@character.hp}."
                end
            end

            if fight == @battle_commands[1]
                if @user_input == "a"
                  puts "You dodged the attack!"
                else
                  puts "You got hit!"
                  @character.lose_hp
                  puts "Your hp is #{@character.hp}."
                end
            end

            if fight == @battle_commands[2]
                if @user_input == "w"
                  puts "You dodged the attack!"
                else
                  puts "You got hit!"
                  @character.lose_hp
                  puts "Your hp is #{@character.hp}."
                end
            end

            if fight == @battle_commands[3]
                if @user_input == "s"
                  puts "You dodged the attack!"
                else
                  puts "You got hit!"
                  @character.lose_hp
                  puts "Your hp is #{@character.hp}."
                end
            end

            if fight == @battle_commands[4]
                if @user_input == "d"
                  puts "You swung your #{@character.chosen_weapon.join} at Zino!"
                  puts ""
                  @boss.hp = @boss.hp - @character.attack
                  puts "Zino's hp is #{@boss.hp}."
                  puts ""
                else
                  puts "You got hit!"
                  @character.lose_hp
                  puts "Your hp is #{@character.hp}."
                end
            end

            if fight == @battle_commands[5]
                if @user_input == "a"
                  puts "You swung your #{@character.chosen_weapon.join} at Zino!"
                  puts ""
                  @boss.hp = @boss.hp - @character.attack
                  puts "Zino's hp is #{@boss.hp}."
                  puts ""
                else
                  puts "You got hit!"
                  @character.lose_hp
                  puts "Your hp is #{@character.hp}."
                end
            end

            if fight == @battle_commands[6]
                if @user_input == "w"
                  puts "You swung your #{@character.chosen_weapon.join} at Zino!"
                  puts ""
                  @boss.hp = @boss.hp - @character.attack
                  puts "Zino's hp is #{@boss.hp}."
                  puts ""
                else
                  puts "You got hit!"
                  @character.lose_hp
                  puts "Your hp is #{@character.hp}."
                end
            end

            if fight == @battle_commands[7]
                if @user_input == "s"
                  puts "You swung your #{@character.chosen_weapon.join} at Zino!"
                  puts ""
                  @boss.hp = @boss.hp - @character.attack
                  puts "Zino's hp is #{@boss.hp}."
                  puts ""
                else
                  puts "You got hit!"
                  @character.lose_hp
                  puts "Your hp is #{@character.hp}."
                end
            end
            sleep(1)
        end
    end

end


eric = Character.new
zino = Zino.new
game = CreateGame.new(character: eric, boss: zino)
game.intro
game.player_intro
game.player_start
game.run