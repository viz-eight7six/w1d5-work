class PolyTreeNode
  attr_reader :parent, :children, :value
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  # def parent
  #   @parent
  # end
  # 
  # def children
  #   @children
  # end
  #
  # def value
  #   @value.dup
  # end

  def parent=(node)
    return nil if @parent == node
    unless self.parent.nil?
      self.parent.children.delete(self)
    end
    @parent = node
    node.children << self unless node.nil?
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    raise "child does not exist" unless self.children.include?(child_node)
    child_node.parent=(nil)
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      found_node = child.dfs(target_value)
      return found_node unless found_node.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      check_node = queue.shift
      return check_node if check_node.value == target_value
      queue += check_node.children
    end
    nil
  end
end
