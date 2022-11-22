io.write("File URL:")
local url = io.read()
shell.run("wget ", url)
