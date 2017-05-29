
$arr_to_sort = []
def merge_sort(arr)
	if arr.length > 1
		merge_sort(arr.slice(0,arr.length/2))
		merge_sort(arr.slice(arr.length/2, arr.length))
	else
		$arr_to_sort << arr 
		return $arr_to_sort
	end 
	return $arr_to_sort.sort!.join
end

print merge_sort([1,5,6,8,7,6,1])
