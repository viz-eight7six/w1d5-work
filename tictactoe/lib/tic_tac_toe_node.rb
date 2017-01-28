require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.won? && @board.winner != next_mover_mark
    self.children.losing_node?(next_mover_mark)


  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each do |row|
      row.each_with_index do |mark, col|
        pos = rows[col]
        p pos
        if @board[pos].empty?
          new_board = @board.dup
          new_board[row,col] = next_mover_mark
          children << TicTacToeNode.new(new_board, next_mover_mark, [row,col])
        end
      end
    end
  end
end
