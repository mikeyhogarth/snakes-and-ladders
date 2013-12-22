class Game

  attr_accessor :players
  attr_accessor :board

  def initialize(opts)
    @number_of_turns = 0

    @players = []
    (opts[:number_of_players] || 1).times { @players << 0 }

    @board = []
    100.times { @board << {} }

    @board[3] = {:ladder => 13}
    @board[8] = {:ladder => 30}
    @board[26] = {:ladder => 83}
    @board[20] = {:ladder => 41}
    @board[16] = {:snake => 6}
    @board[50] = {:ladder => 66}
    @board[53] = {:snake => 33}
    @board[61] = {:snake => 18}
    @board[63] = {:snake => 59}
    @board[86] = {:snake => 23}
    @board[70] = {:ladder => 91}
    @board[97] = {:snake => 78}
    @board[92] = {:snake => 72}
  end

  def take_turn_for_player(player_number)
    return false if @game_is_over

    @number_of_turns += 1

    dice_roll = roll_dice_for_player player_number
    square_player_landed_on = move_player player_number, dice_roll

    exit_the_game(player_number) and return false if square_player_landed_on >= 100

    landed_on = @board[square_player_landed_on]

    if landed_on[:snake]
      puts "Oh no, player #{player_number} landed on a snake and slid down to square #{landed_on[:snake] + 1}"
      @players[player_number - 1] = landed_on[:snake]
    elsif landed_on[:ladder]
      puts "Yay, player #{player_number} landed on a ladder and climbed to square #{landed_on[:ladder] + 1}"
      @players[player_number - 1] = landed_on[:ladder]
    end

    return true
  end

  private
  def move_player(player_number, spaces)
    @players[player_number - 1] += spaces
    return @players[player_number - 1]
  end

  def roll_dice_for_player(player_number)
    dice_roll = rand(6) + 1
    puts "Player #{player_number} got #{dice_roll}"
    return dice_roll
  end

  def exit_the_game(player_number)
    puts "Player #{player_number} won!"
    number_of_seconds_taken = @number_of_turns * 15

    puts "The game would have taken #{number_of_seconds_taken / 60} minutes"
    @game_is_over = true
  end

end

game = Game.new(:number_of_players => 5)

game_is_in_progress = true

while game_is_in_progress
  [1,2,3,4,5].each do |player|
    game_is_in_progress = game.take_turn_for_player player
  end
end
