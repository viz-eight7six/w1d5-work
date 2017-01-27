require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder

  def initialize(pos)
    @pos = pos
    @visited_positions = [pos]
    @root = build_move_tree
  end

  def build_move_tree
    root = PolyTreeNode.new(@pos)
    queue = [root]
    until queue.empty?
      current = queue.shift
      new_move_positions(current.value).each do |pos|
        child = PolyTreeNode.new(pos)
        current.add_child(child)
        queue << child
      end
    end
    root
  end

  def find_path(end_pos)
    final_node = @root.dfs(end_pos)
    trace_path_back(final_node)
  end

  def trace_path_back(node)
    path_arr = [node.value]
    next_node = node.dup
    until next_node.parent.nil?
      # debugger
      path_arr << next_node.parent.value
      next_node = next_node.parent
    end
    path_arr.reverse
  end

  def self.valid_moves(pos)
    x, y = pos
    return true if x <= 7 && x >= 0 && y <= 7 && y >= 0
  end

  def new_move_positions(pos)
    new_pos_arr = []
    x, y = pos
    [-2,-1,1,2].each do |i|
      [-2,-1,1,2].each do |j|
        next if i.abs == j.abs
        new_pos = [x + i, y + j]
        if KnightPathFinder.valid_moves(new_pos)
          unless @visited_positions.include?(new_pos)
            new_pos_arr << new_pos
            @visited_positions << new_pos
          end
        end
      end
    end
    new_pos_arr
  end





end
