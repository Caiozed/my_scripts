class Node
    attr_reader   :value
    attr_accessor :left, :right # :parent necessary?

    def initialize value=nil
      @value = value
      @left  = nil
      @right = nil
    end
  end

  def initialize
    @root = nil
  end

  def add leaf, tree
    return leaf if tree.nil?
    if leaf.value < tree.value
      tree.left.nil? ? tree.left = leaf : add(leaf,tree.left)
    else
      tree.right.nil? ? tree.right= leaf : add(leaf,tree.right)
    end
    leaf
  end

  def build_tree values
  	values.sort!
    @root = Node.new values[values.length/2]
    values.each_with_index do |value,index|
      add Node.new(value), @root if index != values.length/2
    end
  end

puts build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])