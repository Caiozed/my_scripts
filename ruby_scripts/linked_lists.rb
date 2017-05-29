class LinkedList
	def initialize(data) 
		@size = 0
		@list = []

		@list << data
		@size += 1
	end

	def append(data)
		@list[-1].next_node = data
		@list << data
		@size += 1
	end

	def prepend(data)
		data.next_node = @list[0]
		@list.unshift(data)
		@size += 1
	end

	def insert_at(index, value)
		@list[index].value = value
	end

	def remove_at(index)
		@list[index-1].next_node = @list[index+1]
		@list.delete_at(index)
	end

	def size
		puts @size
	end

	def head
		puts @list[0]
	end

	def tail
		puts @list[-1]
	end

	def at(i)
		puts @list[i]
	end

	def pop
		@list[-1].pop
		@list[-1].next_node = nil
		@size -= 1
	end

	def contains?(value)
		for i in (0..@list.length - 1)
			if @list[i].value == value
				return true
			end
		end
		return false
	end

	def find(data)
		for i in (0..@list.length - 1)
			if @list[i].value == data
				return puts i
			end
		end
		return nil
	end

	def to_s
		@list.each{|data| print "#{data} -> "}
	end
end

class Node 
	attr_accessor :value, :next_node
	@next_node = nil
	def initialize(value = nil)
		@value = value
	end
end

node1 = Node.new("b")
node2 = Node.new("c")
node3 = Node.new("d")
node4 = Node.new("a")

list = LinkedList.new(node1)
list.append(node2)
list.append(node3)
list.append(node4)
list.size
list.to_s
puts list.contains?("f")
puts list.find("a")