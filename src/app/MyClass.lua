local MyClass = class("MyClass")
function MyClass:ctor()
	print ("MyClass:ctor()")
	self.X=0
end

function MyClass:test()
	self.X=100

end


return MyClass



