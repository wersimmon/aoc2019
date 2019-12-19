require("intcode")

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

-- Process
output:write("Processing")
targetValue = 19690720
for noun = 0, 99 do
	for verb = 0, 99 do
		local dataCopy = {}
		table.move(data, 0, #data, 0, dataCopy)
		dataCopy[1] = noun
		dataCopy[2] = verb
		
		local result = intcode(dataCopy)
		output:write("\n" .. noun .. "," .. verb .. " (" .. (100 * noun + verb) .. ")'s result was " .. result[0])
		if result[0] == targetValue then
			return
		end
	end
end
