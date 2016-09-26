local Body=class("Body")

local cGridSize=33
local scaleRate=1/display.contentScaleFactor

local function Grid2Pos(x,y)
	local visibleSize=cc.Director:getInstance():getVisibleSize()
	local origin=cc.Director:getInstance():getVisibleOrigin()
	
	local finalX=origin.x+visibleSize.width/2+x*cGridSize*scaleRate
	local finalY=origin.y+visibleSize.height/2+y*cGridSize*scaleRate
	return finalX,finalY

end

function Body:ctor(snake,x,y,node,isHead)
	self.snake=snake
	self.X=x
	self.Y=y
	if isHead then
		self.sp=cc.Sprite:create("head.png")
	else
		self.sp=cc.Sprite:create("body.png")
	end
	
	node:addChild(self.sp)
	
	self:Update()
	

end

function Body:changehead(dir)
	if dir=="left" then
		self.sp=cc.Sprite:create("head.png")
	elseif dir=="right" then
		self.sp=cc.Sprite:create("headr.png")
	elseif dir=="up" then
		self.sp=cc.Sprite:create("headu.png")
	else 
		self.sp=cc.Sprite:create("headd.png")
	end
		self.sp:setPosition(self.X,self.Y)
	self.Update()
end


function Body:Update()
	local posx,posy=Grid2Pos(self.X,self.Y)
	self.sp:setPosition(posx,posy)
	

end

return Body




