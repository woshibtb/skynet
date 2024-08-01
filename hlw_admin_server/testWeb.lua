local skynet = require "skynet"
local socket = require "skynet.socket"
local httpd = require "http.httpd"

local function response(write, status, headers, body)
    local ok, err = httpd.write_response(write, status, headers, body)
    if not ok then
        skynet.error(err)
    end
end

skynet.start(function()
    local id = socket.listen("0.0.0.0", 8001)
    skynet.error("Listening on port 8001")

    socket.start(id, function(id, addr)
        skynet.error(addr .. " connected")
        -- 创建一个读写接口
        local interface = {
            init = nil,
            close = nil,
            read = socket.readfunc(id),
            write = socket.writefunc(id),
        }

        -- 读取 HTTP 请求
        local code, url, method, header, body = httpd.read_request(interface.read)

        -- 构造响应
        response(interface.write, 200, { ["Content-Type"] = "text/plain" }, "Hello Skynet")

        -- 关闭连接
        socket.close(id)
    end)
end)