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
        self:goAround()
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
    if NumEx.NextBool() then
        self:setAction("walk")
    else
        self:setAction("run")
    end

    local dir = Vector3(NumEx.NextInt(-10, 10) / 10, 0, NumEx.NextInt(-10, 10) / 10)
    Utl.RotateTowards(self.transform, dir)
    self.csSelf:invoke4Lua(self:wrapFunction4CS(self.goAround), NumEx.NextInt(40, 100) / 10)
end
--------------------------------------------
return GrRolebase
