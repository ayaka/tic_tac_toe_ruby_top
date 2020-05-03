class Game

  attr_reader :players, :board

  def initialize
    @in_session = true
    @players = []   
    puts
    puts "---Tic Tac Toe ---".center(35)
    @board = Board.new
    create_player(1, "O")
    create_player(2, "X")  
  end

  public

  def play
    while board.marked < 9
      2.times do |i|
        ask_player(i)

        if board.win?(players[i].marker)
          announce_the_winner(i)
          exit
        end

        break if board.marked >= 9
      end 
    end   
    announce_the_draw
  end

  private

  def create_player (n, marker)
    puts "Player #{n}, please enter your name"
    player_name = gets.chomp
    player = Player.new(player_name, marker)
    players << player
  end

  def ask_player(n)
    puts "#{players[n].name}, please select the space to mark"
    players[n].select_space
    check_selection(n)
  end  
  
  def check_selection(n)
    selection = players[n].selection
    if board.space[selection] == "O" || board.space[selection] == "X" || !selection.to_s.match(/^[1-9]$/)
      puts "Not a valid space"
      ask_player(n)
    else
      board.update_board(selection, players[n].marker)
    end
  end
    
  def announce_the_winner(n)
    puts "#{players[n].name} won!\n".center(36)
  end

  def announce_the_draw
    puts "Draw...\n".center(36)
  end
end
  
class Player
  attr_reader :name, :marker
  attr_accessor :selection
  
  def initialize(name,marker)
    @name = name
    @marker = marker
  end
    
  def select_space
    self.selection = gets.chomp.to_i
  end
  
end
  
class Board
  @@WINNING_COMBOS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  attr_reader :space
  attr_accessor :marked

  def initialize
    @space = {}
    (1..9).each { |n| @space[n] = n }
    @marked = 0
    show_board
  end

  public

  def update_board(selection, marker)
    mark_selection(selection, marker)
    self.marked += 1
    show_board
  end

  def win? (marker)
    answer = false
    combos = @@WINNING_COMBOS.map { |combo| combo.map { |n| n = space[n]}}
    combos.each { |combo| answer = true if combo.all?(marker) }
    answer
  end


  private

  def show_board
    puts
    puts "#{space[1]} | #{space[2]} | #{space[3]}".center(35)
    puts "-----------".center(35)
    puts "#{space[4]} | #{space[5]} | #{space[6]}".center(35)
    puts "-----------".center(35)
    puts "#{space[7]} | #{space[8]} | #{space[9]}\n".center(36)
  end

  def mark_selection(selection, marker)
    self.space[selection] = marker
  end
end
  

game = Game.new
game.play


