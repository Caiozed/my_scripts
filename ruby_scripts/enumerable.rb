module Enumerable
	def my_each
		object = self.to_a
		if block_given?
			for i in (0..object.length-1) do
				yield(object[index])
			end
		else
			object.to_enum
		end
	end	

	def my_each_with_index(*object)
		object.length == 0 ? element_size = self.length-1 : element_size = object[0]-1 
		if block_given?
			for i in (0..object.length-1) do
				yield(self[index], index) 
			end
		else
			obj = []
			for i in (0..element_size) do
				obj << self[i]
			end
			obj.to_enum
		end
	end	

	def my_select
		objects = []
		if block_given?
			self.my_each do |element|
				if yield(element)
					objects << element
				end
		else
			objects << self.to_enum
		end
		return(objects)
	end	

	def my_all?
		result = true

		for i in (0..self.length-1) do
			if self[i].nil?
				result = false
				break
			elsif block_given?
				if !yield(self[i])
					result = false
					break
				end
			end
		end
		return(result)
	end


	def my_any?
		result = false

		for i in (0..self.length-1) do
			if block_given? 
				if yield(self[i])
					result = true
					break
				end
			elsif self[i]
					result = true
					break
				end
			end
		end
		return(result)
	end

	def my_none?
		result = false

		if block_given?
			result = self.my_all?{|x| yield(x) == false}
		else
			result = self.myall? {|x| x == false}
		end
		return result
	end

	def my_count(*item)
		result = []
		if block_given?
			result = self.my_select {|x| yield(x)}
		elsif !item.empty?
			result = self.my_select {|x| x == item[0]}
		else
			result = self
		end
		return result.length
	end

	def my_map(&code_block)
		result = []
		if code_block
			result = self.my_select {|x| code_block.call(x)}
		elsif block_given? 
			result = self.my_select {|x| yield(x)}
		else
			result = self.my_select
		end
		
		return result
	end

	def my_inject(*args)
		args_size = args.length
		arr_res = self.to_a
		if block_given?
			args_size == 0 ? memo = arr_res[0] : memo = args[0]
			self.my_each {|item| memo = yield(memo, item)}
		elsif args_size == 1
			if args[0] == :+
				arr_res[0].is_a? String ? memo = "" : memo = 0
			else
				arr_res[0].class != arr_res[1].class ? memo = arr_res[0] : memo = 1
			end


				arr_res.my_each {|item| memo = memo.method(args[0]).call item if item.is_a?(Integer) || (args[0] == :+)}

		elsif args_size == 2 
			memo = args[0]
			arr_res.my_each {|item| memo = memo.method(args[1]).call item}

		end
		
		return memo
	end
end