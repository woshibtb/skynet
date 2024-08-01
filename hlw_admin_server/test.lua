local skynet = require "skynet"

-- 定义 run 函数
local function run()
    skynet.error("This is a test message from the run function.")
end

-- 将 run 函数导出为模块
return {
    run = run
}