local AppleFactory=class("AppleFactory")

local cGridSize=33
local scaleRate=1/display.contentScaleFactor

local function Grid2Pos(x,y)
	local visibleSize=cc.Director:getInstance():getVisibleSize()
	local origin=cc.Director:getInstance():getVisibleOrigin()
	
	local finalX=origin.x+visibleSize.width/2+x*cGridSize*scaleRate
	local finalY=origin.y+visibleSize.height/2+y*cGridSize*scaleRate
	return finalX,finalY

end


function AppleFactory:ctor(bound,node)
	self.bound=bound
	self.node=node
	
	math.randomseed(os.time())
	self:Generate()
end
	
local function getPos(bound)	
	return math.random(-bound,bound)
end


function AppleFactory:Generate()
	if self.appleSprite~=nil then
		self.node:removeChild(self.appleSprite)
	end

	local sp=cc.Sprite:create("apple.png")
	local genBoundLimit=self.bound-1
	
	local x,y=getPos(genBoundLimit),getPos(genBoundLimit)
	local finalX,finalY=Grid2Pos(x,y)
	
	sp:setPosition(finalX,finalY)
	self.node:addChild(sp)
	
	self.appleX=x
	self.appleY=y
	self.appleSprite=sp
end
	
function AppleFactory:CheckCollide(x,y)
	if (x==self.appleX and y==self.appleY) then
		return true
	end
	return false
end

function AppleFactory:Reset()
	self.node:removeChild(self.appleSprite)
end

return AppleFactory

