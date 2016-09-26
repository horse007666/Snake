
local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
    math.randomseed(os.time())
end


function MyApp:run()
	--cc.Director:getInstance():setContentScaleFactor(640/CONFIG_SCREEN_HEIGHT)

	cc.FileUtils:getInstance():addSearchPath("res/")
	self:enterScene("MainScene")
	-- change to my lua script
	--self:enterScene("TitleScene")
end

return MyApp
