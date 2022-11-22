local modem = peripheral.find("modem")
modem.open(43)

local right_coord = 1
local up_coord = 1
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
    
    local mod_x = sizeX % 5
    local mod_z = sizeZ % 5
    

    
    reverse_dir = false
    
    turtle.forward()
    -- for every x column
    for x=1,sizeX do
    
        turtle.suckDown()
        turtle.suckDown()
        print_pos()
        
        if (x + 2) % 5 == 0 or x == sizeX then
            
            if reverse_dir then
                makeTurnLeft()
            else
                makeTurnRight()
            end
            
            -- travel the z row
            local tempModZ = mod_z
            
            for z=1,sizeZ do

                if (right_coord + 2) % 5 == 0 and dig
                then
                    turtle.digDown()
                end
                
                -- Clean up hanging column
                if z < 5 and mod_z > 0 and mod_z < 3 then
                    print(tempModZ)
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
