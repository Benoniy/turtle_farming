local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")
modem.open(15)


local event, side, channel, replyChannel, message, distance
while true do
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    monitor.write(message .. "\n")
end
