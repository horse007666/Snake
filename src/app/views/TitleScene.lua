local TitleScene = class("TitleScene",cc.load("mvc").ViewBase)
	
	

function TitleScene:onCreate()
	display.newSprite("bg.png")	
        :move(display.cx,display.cy)
        :addTo(self)
		
	
	local size=cc.Director:getInstance():getVisibleSize()

	local function callback(ref,type)
		if type==ccui.TouchEventType.ended then
			print("HELLO")
		end
	end
	
	
	local function createStaticButton(layer,imageName,x,y,callback1)
-------------------------------------------the start button	
	--button:setScale(0.15)
	local button=ccui.Button:create()
	button:setTouchEnabled(true)
	button:loadTextures(imageName,imageName,"")
	button:setPosition(x,y)
	button:addClickEventListener(callback1)
	layer:addChild(button)
	end
-----------------------------------------------------------------
--------------  another button--------------------------------


	--self._uiLayer:addChild(button)
	
	local layer=cc.Layer:create()
	
	
	createStaticButton(layer,"btn_start.png",display.cx,display.cy/2,function()
	local newScene=cc.Scene:create()
	local layer=cc.Layer:create()
	--local scene=require("app.views.MainScene")
	--local secondscene=scene:create()
	--local trancescene=cc.TransitionFlipX:create(0.5,secondscene)
	local sprite=cc.Sprite:create("fig13.png")
	sprite:setPosition(display.cx,display.cy)
	sprite:runAction(cc.ScaleTo:create(2,0.5))
	layer:addChild(sprite)
	newScene:addChild(layer)
	cc.Director:getInstance():replaceScene(newScene)
	end
	)
	
	self:addChild(layer)
	createStaticButton(layer,"btn_option.png",display.cx-200,display.bottom+80,callback)
	createStaticButton(layer,"btn_question.png",display.cx,display.bottom+80,callback)
	createStaticButton(layer,"btn_exit.png",display.cx+200,display.bottom+80,callback)
	
	--layer:addChild(button)
	
	
	
end
return TitleScene

