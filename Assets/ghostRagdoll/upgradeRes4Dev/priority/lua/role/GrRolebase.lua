require("public.class")

GrRolebase = class("GrRolebase")

function GrRolebase:ctor(param)
    self.gameObject = nil
end

function GrRolebase:_init(csSelf)
    if self.isInited then
        return
    end
    self.isInited = true
    self.csSelf = csSelf
    self.gameObject = csSelf.gameObject
    self.transform = csSelf.transform
    self.action = csSelf:GetComponent("RdAction")
    self.avata = csSelf:GetComponent("CLRoleAvata")
    self.action:init()
end

function GrRolebase:init(csSelf, param)
    self:_init(csSelf)
    if param.isPlayer then
        self:dress("2")
    else
        self:dress("1")
        GrRolebase:goAround()
    end
end

function GrRolebase:setAction(actionName)
    self.action:setAction(actionName)
end

function GrRolebase:onArrive()

end

function GrRolebase:dress(name)
    self.avata:switch2xx("body", name)
end

-- 四处走走
function GrRolebase:goAround()
    
end
--------------------------------------------
return GrRolebase
