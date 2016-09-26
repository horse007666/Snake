
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
--cc.Directors:getInstance():setContentScaleFactor(640/CONFIG_SCREEN_HEIGHT)


require "config"
require "cocos.init"

local function main()
	local self=cc.Scene:create()
	local layer
	local allPoints

    require("app.MyApp"):create():run()
	
	
	
	
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
