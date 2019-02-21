class Game


  def initialize()
  
      @current_game = GameBoard.new
      @current_game.show_board
  
      puts "Enter name of player 1 :"
      @player1 = gets.chomp 
  
      puts "Enter name of player 2 :"
      @player2 = gets.chomp
  
      Player.new(@player1)
      Player.new(@player2)
  
      @turn = 1
      self.turn
  
  end
  
  def declare_winner(player)
   
      puts "We have a winner! Congrats to #{player}"
      exit
  
  end
  
  
  def turn
  
  while @turn < 10
  
    valid_input = ["1", "2", "3"]  
    error_message = "Invalid input! \nPlease chose a number from 1 to 3"
  
     if @turn % 2 != 0
  
       puts "chose your row, #{@player1}"
       row = gets.chomp
       while !valid_input.include?(row)
         puts error_message   
         row= gets.chomp     
       end 
     
  
       puts "chose your column, #{@player1}"
       column = gets.chomp
       while  !valid_input.include?(column)
       puts error_message
       column= gets.chomp
      end 
  
    if @current_game.place_sym(row, column , "x") == "no"
       puts "Already occupied!"
       @turn = @turn
    
    else 
      @current_game.place_sym(row, column , "x")
      @turn += 1 
    end  
     
  
  
    else  
      puts "chose your row, #{@player2}"
      row = gets.chomp
      while !valid_input.include?(row)
        puts "Invalid input"
        puts "Please chose number from 1 to 3"
        row= gets.chomp   
      end 
  
      puts "chose your column, #{@player2}"
      column = gets.chomp
      while  !valid_input.include?(column)
        puts "Invalid input"
        puts "Please chose number from 1 to 3"
        column= gets.chomp
      end 
    
    if @current_game.place_sym(row, column , "o") == "no"
      puts "Already occupied!"
      @turn = @turn
    
      else 
      @current_game.place_sym(row, column , "o")
      @turn += 1
    end 
    
    end
    
  if @turn>5
    if @current_game.count == "player1"
  
      self.declare_winner("#{@player1}")
    elsif @current_game.count == "player2"
      self.declare_winner("#{@player2}")
    end
  end
  
  
  if @turn == 10
    puts "It 's draw!"
  end
  
  end
  
  end
  
  
  class Player
  
    def initialize(name)
       @name = name
    end
  
    def to_s
      @name
    end
  
  end
  
  
  
  
  class GameBoard
  
    def initialize
      @board = [   
      @top_row =  "_|_|_",
      @middle_row ="_|_|_",
      @bottom_row =" | | " ]  
      @occupied = []
    end
  
    def show_board
      puts [@top_row, @middle_row, @bottom_row]
    end
  
  
  def place_sym(row, col , x_or_o )
    
    new_position = [row,col]
  
    if @occupied.any?  {|pos| pos == new_position}
      return "no"
    else
      @occupied << new_position
    end
  
    
    case col
      when "1"
        col= 0
      when "2" 
       col =2 
      when "3"
       col = 4
    end
    
    case row 
      when "1"
       @top_row[col] = x_or_o
      when "2" 
       @middle_row[col] = x_or_o
      when "3" 
       @bottom_row[col] = x_or_o
    end
    
    self.show_board
  
  end
  
    def count
  
    lines = [
      @top_row[0] + @top_row[2] + @top_row[4],
      @middle_row[0] + @middle_row[2] + @middle_row[4],
      @bottom_row[0] + @bottom_row[2] + @bottom_row[4],
      @top_row[0] +  @middle_row[0]+ @bottom_row[0],
      @top_row[2] +  @middle_row[2]+ @bottom_row[2],
      @top_row[4] +  @middle_row[4]+ @bottom_row[4],
      @top_row[0] +  @middle_row[2]+ @bottom_row[4],
      @top_row[4] +  @middle_row[2]+ @bottom_row[0]
        ]
  
     if lines.any? {|line| line == "xxx"}
        return "player1"
     elsif lines.any? {|line| line == "ooo"}
        return "player2"
     end
     
    end 
  
  
  end
  
  end
  
  
  Game.new
    