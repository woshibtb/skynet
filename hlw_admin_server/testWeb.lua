local skynet = require "skynet"
local httpd = require "http.httpd"
local socket = require "http.sockethelper"
local urllib = require "http.url"

local function handle_request(data)
    local result = "Hello Skynet"
    return result
end

local function start(port)
    local function request_dispatch(session, address)
        local resp = httpd.read_all(session)
        local post = httpd.post_info(resp, "POST")
        local code, message = httpd.response({
            status = 200,
            body = handle_request(post or "")
        })
        socket.write(session, message)
        socket.close(session)
    end

    httpd.listen({
        port = tonumber(port),
        -- 其他配置项可以在这里设置
    }, request_dispatch)
end

skynet.start(function()
    skynet.error("Starting HTTP server on port 8001 ...")
    start(8001)
end)