local min = 172930
local max = 683082

local count = 0
for i = min, max do
	local pass = true
	
	local numbers = {}
	for n in string.gmatch(tostring(i), "%d") do
		table.insert(numbers, math.tointeger(n))
	end
	local maxN = 0
	for n = 1, #numbers do
		if numbers[n] < maxN then
			pass = false
			break
		else
			maxN = numbers[n]
		end
	end
	
	if (
		string.match(tostring(i), "00") == nil and
		string.match(tostring(i), "11") == nil and
		string.match(tostring(i), "22") == nil and
		string.match(tostring(i), "33") == nil and
		string.match(tostring(i), "44") == nil and
		string.match(tostring(i), "55") == nil and
		string.match(tostring(i), "66") == nil and
		string.match(tostring(i), "77") == nil and
		string.match(tostring(i), "88") == nil and
		string.match(tostring(i), "99") == nil
	) then
		pass = false
	end
	
	if pass == true then
		count = count + 1
	end
end

io.output():write("Counted " .. count .. " numbers that match the format")