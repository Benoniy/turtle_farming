local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")
local curs_y = 3
modem.open(15)


monitor.clear()
monitor.setCursorPos(1, 3)


local event, side, channel, replyChannel, message, distance
while true do
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    monitor.write(message .. "\n")
    
    if curs_y == 15 then
        monitor.clear()
        curs_y = 2
    end
    
    curs_y = curs_y + 1
    monitor.setCursorPos(1, curs_y)
end
