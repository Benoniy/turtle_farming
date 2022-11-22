local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")
local curs_y = 1
modem.open(15)


monitor.clear()
monitor.setCursorPos(1, 1)


local event, side, channel, replyChannel, message, distance
while true do
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    monitor.write(message .. "\n")
    
    if curs_y == 18 then
        monitor.clear()
        curs_y = 0
    end
    
    curs_y = curs_y + 1
    monitor.setCursorPos(1, curs_y)
end
