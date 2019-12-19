input = io.input(arg[1])
output = io.output()

-- Read the input into a data table
output:write("Reading the input into data")
data = {}
dIndex = 0
while true do
	local opcode = input:read("n")
	input:seek("cur", 2)	-- Skip the separators
	
	if opcode == nil then	-- If we didn't get an opcode, we're at the end of the input
		break
	else
		data[dIndex] = opcode
		dIndex = dIndex + 1
		output:write(".")
	end
end
output:write("\n")

-- Set the 1202 program alarm
data[1] = 12
data[2] = 2

-- Process
output:write("Processing");
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
		output:write(".")
		
	elseif opcode == 2 then
		-- Multiply
		local aIndex = data[programCounter + 1]
		local bIndex = data[programCounter + 2]
		local resultIndex = data[programCounter + 3]
		data[resultIndex] = data[aIndex] * data[bIndex]
		
		programCounter = programCounter + 4
		output:write(".")
		
	elseif opcode == 99 then
		-- Halt
		break
	else
		output:write("(WARN: Unrecognized opcode " .. opcode .. " at index " .. programCounter .. "!)")
	end
end
output:write("\n")

-- Output result
output:write("data[0]: " .. data[0] .. "\n");
