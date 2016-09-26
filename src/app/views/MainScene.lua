
local MainScene = class("MainScene", cc.load("mvc").ViewBase)


local myclass=require("app.MyClass").new()
--local mycalss=MyClass:new()

local cMoveSpeed=0.3
local cBound=9

--require("app.CollideManager")

--require("app.CollideManager").ResetCollide()


function MainScene:onCreate()
    ------ add background image
	-- display.newSprite("bg.png")
	    -- :move(display.center)
        -- :addTo(self)
	self.havedoneeffect={}
	local layer=cc.Layer:create()
	self:addChild(layer)
	--self.snake=require("app.Body").new(nil,5,5,self,false)
	--self.mycalss=require("app.MyClass").new()
	--self.sp=cc.Sprite:create("head.png")
	--self:addChild(self.sp)
	
	-- self.snake=require("app.Snake").new(self)
	-- self.appleFactory=require("app.appleFactory").new(cBound,self)
	-- self.stage="running"
	
	self.fence=require("app.Fence").new(cBound,self)
	self:CreateScoreBoard()
	self:Reset()
	self:ProcessInput()
	
	local tick=function()
		if self.stage=="running" then
			self.snake:Update()
			local headX,headY=self.snake:GetHeadGrid()
			if self.appleFactory:CheckCollide(headX,headY) then
				self.appleFactory:Generate()
				self.snake:Grow()
				self.score=self.score+1
				self:SetScore(self.score)
			end
			
			if self.snake:CheckSelfCollide() or self.fence:CheckCollide(headX,headY) then
				self.stage="dead"
				--self.flag=require("app.Body").new(nil,5,5,self,false)
				self.snake:Blink(function()
					self:Reset()
				end
				)
				
			end
			
			
			-- if self.snake:GetLength()%5==0 and self.havedoneeffect[self.snake:GetLength()]==nil then
			-- --if self.snake:GetLength()%5==0 then
				-- self.havedoneeffect[self.snake:GetLength()]=true
				-- self.stage="seeMMtime"
				-- math.randomseed(os.time())
				-- self.mmsp=cc.Sprite:create(string.format("mm%d.png",math.random(1,3)))
				-- --self.mmsp=cc.Sprite:create("mm3.png")
				-- self:addChild(self.mmsp)
				-- self.mmsp:setPosition(display.cx,display.cy)
				-- --self.mmsp:runAction(cc.Blink:create(3,5))
				-- self.mmsp:runAction(cc.Sequence:create(cc.ScaleTo:create(1,0.5),cc.CallFunc:create(   function() 
				-- self:removeChild(self.mmsp)
				-- --self:Reset()
				-- self.stage="running"
				-- end   )))
				-- --self.mmsp:runAction(cc.Sequence:create(cc.ScaleTo:create(3,0.5)))
				-- --self:removeChild(self.mmsp)
				-- --self.stage="running"
				-- --self:Reset()
			-- end
		end
		
	end
	
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick,cMoveSpeed,false)
	
end

local function vector2Dir(x,y)
	if math.abs(x)>math.abs(y) then
		if x<0 then
			return "left"
		else 
			return "right"
		end	
	else
		if y<0 then
			return "down"
		else 
			return "up"
		end	
	end
end

function MainScene:ProcessInput()
	local function onTouchBegan(touch,event)
		local location=touch:getLocation()
		local VisibleSize=cc.Director:getInstance():getVisibleSize()
		local origin=cc.Director:getInstance():getVisibleOrigin()
		
		local finaX=location.x-(origin.x+VisibleSize.width/2)
		local finaY=location.y-(origin.x+VisibleSize.height/2)
		local dir=vector2Dir(finaX,finaY)
		self.snake:SetDir(dir)
	end

	local listener=cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher=self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
	
end

function MainScene:CreateScoreBoard()
	display.newSprite("score.png")
		:move(display.right-100,display.cy+150)
		:addTo(self)
		
	local ttfConfig={}
	ttfConfig.fontFilePath="arial.ttf"
	ttfConfig.fontSize =30
	
	--local score=cc.Label:createWithTTF(ttfConfig,"0")
	local score=cc.Label:createWithSystemFont("0", "Arial", ttfConfig.fontSize)
	self:addChild(score)
	
	score:setPosition(display.right-100,display.cy+80)
	self.scoreLabel=score
	
end

function MainScene:SetScore(s)
	self.scoreLabel:setString(string.format("%d",s))

end


function MainScene:Reset()
	if self.snake~=nil then
		self.snake:Kill()
	end

	if self.appleFactory~=nil then
		self.appleFactory:Reset()
	end
	self.snake=require("app.Snake").new(self)
	self.appleFactory=require("app.appleFactory").new(cBound,self)
	
	self.stage="running"
	self.score=0
	self:SetScore(self.score)
	
	for key,flag in pairs(self.havedoneeffect) do
		self.havedoneeffect[index]=nil
	end
	
end




return MainScene



