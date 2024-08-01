local skynet = require "skynet"

-- 定义 run 函数
local function run()
    skynet.error("This is a test message from the run function.")
end

local function GetResponse()
    local strResponse = [[
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>Hello Skynet</title>
        </head>
        <body>
            <h1>Hello Skynet</h1>
            <h2>Good day today</h2>
            <h2>32167</h2>
        </body>
        </html>
    ]]
    return strResponse
end

-- 将 run 函数导出为模块
return {
    run = run,
    GetResponse = GetResponse
}