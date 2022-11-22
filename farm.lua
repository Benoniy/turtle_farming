function dig_plane(sizeX, sizeZ, dig)

	sizeZ = sizeZ - 1
	reverse_dir = false
	
	turtle.forward()
	-- for every x column
	for x=1,sizeX do
	
		turtle.suckDown()
		turtle.suckDown()
		
		if (x + 2) % 5 == 0 or x == sizeX then
		
			
			if reverse_dir then
				turtle.turnLeft()
			else
				turtle.turnRight()
			end
			
			-- travel the z row
			for z=1,sizeZ do
			
				if (z + 2) % 5 == 0 and dig
				then
					turtle.digDown()
				end
				turtle.suckDown()
				turtle.suckDown()
				turtle.forward()
			end
			
			-- turn to front
			if reverse_dir then
				turtle.turnRight()
				reverse_dir = false
			else
				turtle.turnLeft()
				reverse_dir = true
			end
			
			turtle.forward()
		else
			turtle.forward()
		end
		
	end
	
	turtle.turnLeft()
	turtle.turnLeft()
	recover_seeds(sizeX, sizeZ + 1)
end


function recover_seeds(sizeX, sizeZ)

	sizeX = sizeX - 1
	sizeZ = sizeZ - 1
	reverse_dir = false
	
	turtle.forward()
	-- for every x column
	for x=1,sizeX do
	
		turtle.suckDown()
		turtle.suckDown()
		
			
		if reverse_dir then
			turtle.turnLeft()
		else
			turtle.turnRight()
		end
			
			-- travel the z row
		for z=1,sizeZ do
			turtle.suckDown()
			turtle.suckDown()
			turtle.forward()
		end
			
		-- turn to front
		if reverse_dir then
			turtle.turnRight()
			reverse_dir = false
		else
			turtle.turnLeft()
			reverse_dir = true
		end
			
		turtle.forward()

	end
	
	turtle.turnLeft()
	turtle.turnLeft()
end

turtle.refuel( 64 )

-- dig_plane(10, 10, true)
dig_plane(10, 10, false)
