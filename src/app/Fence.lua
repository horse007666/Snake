local Fence=class("Fence")

local cGridSize=33
local scaleRate=1/display.contentScaleFactor

local function Grid2Pos(x,y)
	local visibleSize=cc.Director:getInstance():getVisibleSize()
	local origin=cc.Director:getInstance():getVisibleOrigin()
	
	local finalX=origin.x+visibleSize.width/2+x*cGridSize*scaleRate
	local finalY=origin.y+visibleSize.height/2+y*cGridSize*scaleRate
	return finalX,finalY

end

local function fenceGenerator(node,bound,callback)
	for i=-bound,bound do
		local sp=cc.Sprite:create("fence.png")
		local posx,posy=callback(i)
		sp:setPosition(posx,posy)
		node:addChild(sp)
	end
end





function Fence:ctor(bound,node)
	self.bound=bound
	--up
	fenceGenerator(node,bound,function(i)
		return Grid2Pos(i,bound)
	end)
	--down
	fenceGenerator(node,bound,function(i)
		return Grid2Pos(i,-bound)
	end)
	--left
	fenceGenerator(node,bound,function(i)
		return Grid2Pos(-bound,i)
	end)
	--right
	fenceGenerator(node,bound,function(i)
		return Grid2Pos(bound,i)
	end)
	
end

function Fence:CheckCollide(x,y)
	return x==self.bound or x==-self.bound or y==self.bound or y==-self.bound
end




return Fence