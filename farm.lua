local modem = peripheral.find("modem")
modem.open(43)


local right_coord = 1
local up_coord = 1
local dig_last_x = false
local dig_last_z = false

local orientation = 1

function print_pos()
    local message = "x=" .. tostring(up_coord) .. ", y=" .. tostring(right_coord) .. ", r=" .. tostring(orientation)
    modem.transmit(15, 43, message)
end

-- 0 is left, 1 is forward, 2 is right and 3 is back
function change_orientation(turn_dir)
    if turn_dir == 1 then
        orientation = orientation + 1
    elseif turn_dir == -1 then
        orientation = orientation - 1
    end
    if orientation > 3 then
        orientation = 0
    elseif orientation < 0 then
        orientation = 3
    end
end

function makeTurnLeft()
    turtle.turnLeft()
    change_orientation(-1)
end

function makeTurnRight()
    turtle.turnRight()
    change_orientation(1)
end


function dig_plane(sizeX, sizeZ, dig)
    sizeZ = sizeZ - 1
    reverse_dir = false
    turtle.forward()
    
    local tempx = tonumber(string.sub(tostring(sizeX), -1))
    local tempz = tonumber(string.sub(tostring(sizeZ + 1), -1))

    if tempx == 1 or tempx == 2 or tempx == 6 or tempx == 7 then
        dig_last_x = true
    end
    
    if tempz == 1 or tempz == 2 or tempz == 6 or tempz == 7 then
        dig_last_z = true
    end 
    
    -- for every x column
    for x=1,sizeX do
    
        turtle.suckDown()
        turtle.suckDown()
        print_pos()
        
        if dig_last_x and up_coord == sixeX then
            dig = true
        elseif not dig_last_x and up_coord == sixeX then
            dig = false
        end
        
        if (x + 2) % 5 == 0 or x == sizeX then
            
            if reverse_dir then
                makeTurnLeft()
            else
                makeTurnRight()
            end
            
            -- travel the z row
            for z=1,sizeZ do
                
                if (right_coord + 2) % 5 == 0 and dig then
                    turtle.digDown()
                end  
                
                -- Clean up hanging column
                if dig_last_z and right_coord == sizeZ + 1 and dig then
                    turtle.digDown()
                end
                
                turtle.suckDown()
                turtle.suckDown()
                turtle.forward()
                
                if reverse_dir then
                    right_coord = right_coord - 1
                else
                    right_coord = right_coord + 1
                end
                
                -- Clean up hanging column
                if dig_last_z and right_coord == sizeZ + 1 and dig then
                    turtle.digDown()
                end
                
                print_pos()
            end
            
            -- turn to front
            if reverse_dir then
                makeTurnRight()
                reverse_dir = false
            else
                makeTurnLeft()
                reverse_dir = true
            end
            
            turtle.forward()
            up_coord = up_coord + 1
        else
            turtle.forward() 
            up_coord = up_coord + 1
        end
    end
    
    -- End at the correct point
    if right_coord < sizeZ + 1 then
        while orientation ~= 2 do
            makeTurnRight()
        end
        while right_coord < (sizeZ + 1) do
            turtle.forward()
            right_coord = right_coord + 1
        end
        makeTurnLeft()
    end
      
                    
    makeTurnLeft()
    makeTurnLeft()
    -- recover_seeds(sizeX, sizeZ + 1)
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
dig_plane(11, 11, true)
