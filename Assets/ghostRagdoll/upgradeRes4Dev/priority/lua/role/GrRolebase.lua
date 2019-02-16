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
end

function GrRolebase:init(csSelf, param)
    self:_init(csSelf)
end

function GrRolebase:setAction(actionName)
    self.action:setAction(actionName)
end

function GrRolebase:onArrive()

end

--------------------------------------------
return GrRolebase
