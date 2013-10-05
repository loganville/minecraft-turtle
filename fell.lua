--fell program
FUEL = 1
WOOD = 2
SAPLING = 3
FURNACE = 4
function look_for_x(x)
	local index = 1
	for index = 1,4 do
		turtle.turnLeft()
		suck()
		if (compare(x)) then
			return true
		end
	end
	return false
end

function suck()
	turtle.select(FURNACE)
	if turtle.compareUp() then
		turtle.select(FUEL)
		turtle.suckUp()
		print ("found furnace")
	end
	turtle.select(SAPLING)
	turtle.suck()
end

function plant()
	while turtle.down() do
		print ("comming down")
	end
	turtle.select(SAPLING)
	turtle.place()
end

function compare(x)
	turtle.select(x)
	return turtle.compare()
end

function chop()
	turtle.select(WOOD)
	turtle.dig()
end

function fell_tree()
	chop()
	local safety = 0
	while safety < 20 do
		if turtle.up() then
			safety = safety + 1
			if turtle.compare(WOOD) then
				chop()
			else
				plant()
				turtle.turnRight()
				break
			end
		else
			turtle.digUp()
		end
	end
	if safety == 20 then
		while turtle.down() do
			print ('oh noes')
		end
		error()
	end
end

function refuel()
	turtle.select(FUEL)
	turtle.refuel()
end

function move()
	if not turtle.forward() then
		turtle.turnLeft()
		turtle.forward()
	end
	if look_for_x(WOOD) then
		fell_tree()
	end
end

function init()
	if turtle.getFuelLevel() < 10 then
		refuel()
	end
	while turtle.down() do
		print("coming down..")
	end
	turtle.select(FUEL)
	while true do
		refuel(1)
		move()
	end
end

init()
