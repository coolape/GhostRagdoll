local GrRoleAction = {}
local actionCfg
local csSelf
local root

local joinMap = {}

function GrRoleAction.init(_csSelf, actionCfgName)
    csSelf = _csSelf

    root = csSelf.root--;//根节点
    joinMap[JoinName.head] = csSelf.head--;//头
    joinMap[JoinName.spine] = csSelf.spine--;//脊柱
    joinMap[JoinName.leftUpperArm] = csSelf.leftUpperArm--;//左上臂
    joinMap[JoinName.leftForeArm] = csSelf.leftForeArm--;//左前臂
    joinMap[JoinName.leftThigh] = csSelf.leftThigh--; //左大腿
    joinMap[JoinName.leftCalf] = csSelf.leftCalf--;//左小腿
    joinMap[JoinName.leftFoot] = csSelf.leftFoot--;//左脚
    joinMap[JoinName.rightUpperArm] = csSelf.rightUpperArm--;//右上臂
    joinMap[JoinName.rightForeArm] = csSelf.rightForeArm--;//右前臂
    joinMap[JoinName.rightThigh] = csSelf.rightThigh--; //右大腿
    joinMap[JoinName.rightCalf] = csSelf.rightCalf--;//右小腿
    joinMap[JoinName.rightFoot] = csSelf.rightFoot--;//右脚

    actionCfg = require("cfgAction." .. actionCfgName)
end

function GrRoleAction.setAction(actionNname)
    local actionFunc = GrRoleAction[actionNname]
    if actionFunc then
        actionFunc()
    else
        GrRoleAction.playActionCom(actionNname)
    end
end

function GrRoleAction.getSpeed(speed)
    local ret = 0
    if type(speed) == "function" then
        ret = speed()
    else
        ret = speed
    end
    return ret
end

function GrRoleAction.idel()
    local cfg = actionCfg.idel[JoinName.thigh]
    local speed = cfg[JoinSpringKeys.speed]
    local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
    local min = cfg[JoinSpringKeys.min]
    local max = cfg[JoinSpringKeys.max]
    local mode = cfg[JoinSpringKeys.mode]
    local times = cfg[JoinSpringKeys.times]
    local spring = cfg[JoinSpringKeys.spring]
    local to = cfg[JoinSpringKeys.to]
    joinMap[JoinName.leftThigh]:spring(spring, to, GrRoleAction.getSpeed(speed), curve, min, max, mode, times, nil, nil)
    joinMap[JoinName.rightThigh]:spring(spring, to, GrRoleAction.getSpeed(speed), curve, min, max, mode, times, nil, nil)
end

function GrRoleAction.run()
    local cfg = actionCfg.run[JoinName.thigh]
    local speed = cfg[JoinSpringKeys.speed]
    local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
    local min = cfg[JoinSpringKeys.min]
    local max = cfg[JoinSpringKeys.max]
    local mode = cfg[JoinSpringKeys.mode]
    local times = cfg[JoinSpringKeys.times]
    local spring = cfg[JoinSpringKeys.spring]
    local from = cfg[JoinSpringKeys.from]
    local to = cfg[JoinSpringKeys.to]
    joinMap[JoinName.leftThigh]:spring(spring, from, to, GrRoleAction.getSpeed(speed), curve, min, max, mode, times, nil, nil)
    joinMap[JoinName.rightThigh]:spring(spring, to, from, GrRoleAction.getSpeed(speed), curve, min, max, mode, times, nil, nil)
end

function GrRoleAction.walk()
    GrRoleAction.walkrightFinish(false)
end

function GrRoleAction.walkleftFinish(reverse)
    local cfg = actionCfg.walk[JoinName.thigh]
    local speed = cfg[JoinSpringKeys.speed]
    local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
    local min = cfg[JoinSpringKeys.min]
    local max = cfg[JoinSpringKeys.max]
    local mode = cfg[JoinSpringKeys.mode]
    local times = cfg[JoinSpringKeys.times]
    local spring = cfg[JoinSpringKeys.spring]
    local from = cfg[JoinSpringKeys.from]
    local to = cfg[JoinSpringKeys.to]
    if (reverse) then
        from = cfg[JoinSpringKeys.from]
        to = cfg[JoinSpringKeys.to]
    else
        from = cfg[JoinSpringKeys.to]
        to = cfg[JoinSpringKeys.from]
    end
    joinMap[JoinName.leftThigh]:spring(spring, from, to, GrRoleAction.getSpeed(speed), curve, min, max, mode, times, GrRoleAction.walkrightFinish, (not reverse))
end

function GrRoleAction.walkrightFinish(reverse)
    local cfg = actionCfg.walk[JoinName.thigh]
    local speed = cfg[JoinSpringKeys.speed]
    local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
    local min = cfg[JoinSpringKeys.min]
    local max = cfg[JoinSpringKeys.max]
    local mode = cfg[JoinSpringKeys.mode]
    local times = cfg[JoinSpringKeys.times]
    local spring = cfg[JoinSpringKeys.spring]
    local from = cfg[JoinSpringKeys.from]
    local to = cfg[JoinSpringKeys.to]
    if (reverse) then
        from = cfg[JoinSpringKeys.from]
        to = cfg[JoinSpringKeys.to]
    else
        from = cfg[JoinSpringKeys.to]
        to = cfg[JoinSpringKeys.from]
    end
    if joinMap[JoinName.rightThigh] == nil then
        printe(JoinName.rightThigh)
    end
    local rightThigh = joinMap[JoinName.rightThigh]
    rightThigh:spring(spring, from, to, GrRoleAction.getSpeed(speed), curve, min, max, mode, times, GrRoleAction.walkleftFinish, (reverse))
end

function GrRoleAction.playActionCom(actionName, callback, orgs)
    local attr = actionCfg[actionName]
    if attr == nil then
        return
    end
    for joinKey, cfg in pairs(attr) do
        local joint = joinMap[joinKey]
        local speed = cfg[JoinSpringKeys.speed]
        local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
        local min = cfg[JoinSpringKeys.min]
        local max = cfg[JoinSpringKeys.max]
        local mode = cfg[JoinSpringKeys.mode]
        local times = cfg[JoinSpringKeys.times]
        local spring = cfg[JoinSpringKeys.spring]
        local from = cfg[JoinSpringKeys.from]
        local to = cfg[JoinSpringKeys.to]
        joint:spring(spring, from, to, GrRoleAction.getSpeed(speed), curve, min, max, mode, times, callback, orgs)
    end
end

--------------------------------------------
return GrRoleAction
