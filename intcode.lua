function intcode(data)
	programCounter = 0
	while true do
		local opcode = data[programCounter]
		
		if opcode == 1 then
			-- Add
			local aIndex = data[programCounter + 1]
			local bIndex = data[programCounter + 2]
			local resultIndex = data[programCounter + 3]
			data[resultIndex] = data[aIndex] + data[bIndex]
			
			programCounter = programCounter + 4
			
		elseif opcode == 2 then
			-- Multiply
			local aIndex = data[programCounter + 1]
			local bIndex = data[programCounter + 2]
			local resultIndex = data[programCounter + 3]
			data[resultIndex] = data[aIndex] * data[bIndex]
			
			programCounter = programCounter + 4
			
		elseif opcode == 99 then
			-- Halt
			break
		end
	end
	
	return data
end
