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
    self.action:init()
    self.avata = csSelf:GetComponent("CLRoleAvata")
    self.seeker = csSelf:GetComponent("RdAIPath")
    if self.seeker then
        self.seeker:init(self:wrapFunction4CS(self.onFinishSeek), nil, self:wrapFunction4CS(self.onArrive))
    end
end

function GrRolebase:init(csSelf, param)
    self:_init(csSelf)
    self.state = RoleState.idel

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

function GrRolebase:onFinishSeek(pathList, canReach)
    if self.state == RoleState.walkAround then
        if NumEx.NextBool() then
            self:setAction("walk")
        else
            self:setAction("run")
        end
    end
end

function GrRolebase:onArrive()
    self:setAction("idel")
    if self.state == RoleState.walkAround then
        self.csSelf:invoke4Lua(self:wrapFunction4CS(self.goAround), NumEx.NextInt(10, 50) / 10)
    end
end

function GrRolebase:dress(name)
    self.avata:switch2xx("body", name)
end

-- 四处走走
function GrRolebase:goAround()
    self.state = RoleState.walkAround
    self.seeker:moveTo(GrGame.getFreePos())

    --local dir = Vector3(NumEx.NextInt(-10, 10) / 10, 0, NumEx.NextInt(-10, 10) / 10)
    --Utl.RotateTowards(self.transform, dir)
    --self.csSelf:invoke4Lua(self:wrapFunction4CS(self.goAround), NumEx.NextInt(40, 100) / 10)
end
--------------------------------------------
return GrRolebase
