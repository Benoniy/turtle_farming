local modem = peripheral.find("modem")
modem.open(43)

local right_coord = 0
local up_coord = 0
local orientation = 1

-- 0 is left, 1 is forward, 2 is right and 3 is back
function change_orientation(turn_dir)
    if turnd_dir == 1 then
        orientation = orientation + 1
    elseif turnd_dir == -1 then
        orientation = orientation - 1
    end
    if orientation > 3 then
        orientation = 0
    elseif orientation < 0 then
        orientation = 3
    end
end

function turn_left()
    turtle.turnLeft()
    change_orientation(-1)
end

function turn_right()
    turtle.turnRight()
    change_orientation(1)
end


function dig_plane(sizeX, sizeZ, dig)
    sizeZ = sizeZ - 1
    
    local mod_x = sizeX % 5
    local mod_z = sizeZ % 5
    

    
    reverse_dir = false
    
    turtle.forward()
    -- for every x column
    for x=1,sizeX do
    
        turtle.suckDown()
        turtle.suckDown()
        
        if (x + 2) % 5 == 0 or x == sizeX then
        
            
            if reverse_dir then
                turn_left()
            else
                turn_right()
            end
            
            -- travel the z row
            local tempZ = sizeZ
            local tempModZ = mod_z
            
            for z=1,sizeZ do

                if (z + 2) % 5 == 0 and dig
                then
                    turtle.digDown()
                end
                
                -- Clean up hanging column
                if tempZ < 5 and 3 < mod_z > 0 then
                    if tempModZ == 0 then
                        turtle.digDown()
                    else
                        tempModZ = tempModZ - 1
                    end
                end
                    
                    
                turtle.suckDown()
                turtle.suckDown()
                turtle.forward()
                
                if reverse_dir then
                    right_coord = right_coord - 1
                else
                    right_coord = right_coord + 1
                end
                
                tempZ = tempZ - 1
                
                local message = "x= " .. tostring(up_coord) .. ", y=" .. tostring(right_coord) .. ", r=" + tostring(orientation)
                modem.transmit(15, 43, message)
            end
            
            -- turn to front
            if reverse_dir then
                turn_right()
                reverse_dir = false
            else
                turtle.turnLeft()
                reverse_dir = true
            end
            
            turtle.forward()
            up_coord = up_coord + 1
        else
            turtle.forward() 
            up_coord = up_coord + 1
        end
        
    end
    
    turn_left()
    turn_left()
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
dig_plane(10, 10, false)
