const fs = require("fs");

const data = fs.readFileSync(process.argv[2], {encoding: "utf8"})
const grid = {};

// Draw wires
process.stdout.write("Drawing wires");
const wires = data.split("\n");
wires.forEach(function(wire, wireNumber) {
	process.stdout.write(`\nDrawing wire ${wireNumber}`);
	
	let cursorX = 0;
	let cursorY = 0;
	wire.split(",").forEach(function(span) {
		const match = span.match(/(\w)(\d+)/);
		const direction = match[1];
		const length = Number.parseInt(match[2], 10);
		switch(direction) {
			case "U":
				for(let y = 1; y <= length; y++) {
					grid[cursorX] = grid[cursorX] || {};
					grid[cursorX][cursorY + y] = grid[cursorX][cursorY + y] || new Set();
					grid[cursorX][cursorY + y].add(wireNumber);
				}
				cursorY += length;
				break;
				
			case "D":
				for(let y = 1; y <= length; y++) {
					grid[cursorX] = grid[cursorX] || {};
					grid[cursorX][cursorY - y] = grid[cursorX][cursorY - y] || new Set();
					grid[cursorX][cursorY - y].add(wireNumber);
				}
				cursorY -= length;
				break;
				
			case "L":
				for(let x = 1; x <= length; x++) {
					grid[cursorX - x] = grid[cursorX - x] || {};
					grid[cursorX - x][cursorY] = grid[cursorX - x][cursorY] || new Set();
					grid[cursorX - x][cursorY].add(wireNumber);
				}
				cursorX -= length;
				break;
				
			case "R":
				for(let x = 1; x <= length; x++) {
					grid[cursorX + x] = grid[cursorX + x] || {};
					grid[cursorX + x][cursorY] = grid[cursorX + x][cursorY] || new Set();
					grid[cursorX + x][cursorY].add(wireNumber);
				}
				cursorX += length;
				break;
				
			default:
				throw `Did not recognize direction "${direction}"`;
		}
		process.stdout.write(".");
	});
});
process.stdout.write("\n");

// Find all the intersections
process.stdout.write(`Finding nodes with ${wires.length} wires`);
let intersections = [];
for(let distance = 1; intersections.length == 0; distance++) {
	for(let i = -distance; i <= distance; i++) {
		if(grid[i][ distance] && grid[i][ distance].size == wires.length) intersections.push([i,  distance]);
		if(grid[i][-distance] && grid[i][-distance].size == wires.length) intersections.push([i, -distance]);
		if(grid[ distance][i] && grid[ distance][i].size == wires.length) intersections.push([ distance, i]);
		if(grid[-distance][i] && grid[-distance][i].size == wires.length) intersections.push([-distance, i]);
	}
	process.stdout.write(".");
}
process.stdout.write(`\nFound ${intersections.length} intersections\n`);

// Find the closest intersection
const closestIntersection = intersections.sort(function(a, b) {
	return (Math.abs(a[0]) + Math.abs(a[1])) - (Math.abs(b[0]) + Math.abs(b[1]));
})[0];
console.log(`${closestIntersection[0]}, ${closestIntersection[1]}: ${(Math.abs(closestIntersection[0]) + Math.abs(closestIntersection[1]))} away`);