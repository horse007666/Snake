local Snake = class("Snake")
local Body=require("app.Body")
local cInitLen=9

function Snake:ctor(node)
	self.BodyArray={}
	self.node=node
	self.MoveDir="left"
	
	for i=1,cInitLen do
		self:Grow(i==1)
	end
	self:SetDir("left")
end

function Snake:GetTailGrid()
	if #self.BodyArray==0 then
		return 0,0
	end
	local tail=self.BodyArray[#self.BodyArray]
	return tail.X,tail.Y
end


function Snake:GetHeadGrid()
	if #self.BodyArray==0 then
		return nil
	end
	local head=self.BodyArray[1]
	return head.X,head.Y
end


function Snake:Grow(isHead)
	local tailX,tailY=self:GetTailGrid()
	local body_tmp=require("app.Body").new(self,tailX,tailY,self.node,isHead)
	table.insert(self.BodyArray,body_tmp)
end


local function OffsetGridByDir(x,y,dir)
	if dir =="left" then
		return x-1,y
	elseif dir=="right" then
		return x+1,y  
	elseif dir=="up"  then
		return x,y+1
	elseif dir=="down"  then
		return x,y-1
	end
end

local hvTable={
	["left"]="h",
	["right"]="h",
	["up"]="v",
	["down"]="v",
}

local rotTable={
	["left"]=-90,
	["right"]=90,
	["up"]=0,
	["down"]=180,
}




function Snake:SetDir(dir)
	if hvTable[dir]==hvTable[self.MoveDir] then
		return
	end
	self.MoveDir=dir
	local head=self.BodyArray[1]
	head.sp:setRotation(90+rotTable[self.MoveDir])
	
end

function Snake:Update()
	if #self.BodyArray==0 then
		return 0,0
	end
	
	-- --YXXX
	for i =#self.BodyArray,1,-1 do
	local body=self.BodyArray[i]
		if i==1 then
			--body.changehead(self.MoveDir)
			body.X,body.Y=OffsetGridByDir(body.X,body.Y,self.MoveDir)
			--body.changehead(self.MoveDir)
			--require("app.Body").new(self,body.X+5,body.Y+5,self.node,false)
			
		else
			local front=self.BodyArray[i-1]
			-- -- -- ------set the body value to be the front one
			body.X,body.Y=front.X,front.Y
		end
		body:Update()
	end
end

function Snake:CheckSelfCollide()
	if #self.BodyArray<2 then
		return false
	end
	local headX,headY=self:GetHeadGrid()
	for i=2,#self.BodyArray do
		local body=self.BodyArray[i]
		if (body.X==headX and body.Y==headY) then
			return true
		end
		
	end
	return false
end

function Snake:Kill()
	for _,body in ipairs(self.BodyArray) do
		self.node:removeChild(body.sp)
	end
end

function Snake:Blink(callback)
	for index,body in ipairs(self.BodyArray) do
		local blink=cc.Blink:create(3,5)  ---- 3seconds, blink 5 times
		if index==1 then
			local a=cc.Sequence:create(blink,cc.CallFunc:create(callback))
			body.sp:runAction(a)
		else 
			body.sp:runAction(blink)
		
		end
	
	end
end

function Snake:GetLength()
	return #self.BodyArray
end


return Snake










