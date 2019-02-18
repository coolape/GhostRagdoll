local GrRoleAction = {}
local actionCfg
local csSelf

local root--;//根节点
local head--;//头
local spine--;//脊柱
local leftUpperArm--;//左上臂
local leftForeArm--;//左前臂
local leftThigh--; //左大腿
local leftCalf--;//左小腿
local leftFoot--;//左脚
local rightUpperArm--;//右上臂
local rightForeArm--;//右前臂
local rightThigh--; //右大腿
local rightCalf--;//右小腿
local rightFoot--;//右脚

function GrRoleAction.init(_csSelf, actionCfgName)
    csSelf = _csSelf

    root = csSelf.root--;//根节点
    head = csSelf.head--;//头
    spine = csSelf.spine--;//脊柱
    leftUpperArm = csSelf.leftUpperArm--;//左上臂
    leftForeArm = csSelf.leftForeArm--;//左前臂
    leftThigh = csSelf.leftThigh--; //左大腿
    leftCalf = csSelf.leftCalf--;//左小腿
    leftFoot = csSelf.leftFoot--;//左脚
    rightUpperArm = csSelf.rightUpperArm--;//右上臂
    rightForeArm = csSelf.rightForeArm--;//右前臂
    rightThigh = csSelf.rightThigh--; //右大腿
    rightCalf = csSelf.rightCalf--;//右小腿
    rightFoot = csSelf.rightFoot--;//右脚

    actionCfg = require("cfgAction." .. actionCfgName)
end

function GrRoleAction.setAction(actionNname)
    GrRoleAction[actionNname]();
end

function GrRoleAction.idel()
    local cfg = actionCfg.idel[JoinName.thigh]
    local speed = cfg[JoinSpringKeys.speed]
    local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
    local min = csSelf[cfg[JoinSpringKeys.min]]
    local max = csSelf[cfg[JoinSpringKeys.max]]
    local mode = cfg[JoinSpringKeys.mode]
    local times = cfg[JoinSpringKeys.times]
    local spring = cfg[JoinSpringKeys.spring]
    local to = cfg[JoinSpringKeys.to]
    leftThigh:spring(spring, to, speed, curve, min, max, mode, times, nil, nil)
    rightThigh:spring(spring, to, speed, curve, min, max, mode, times, nil, nil)
end

function GrRoleAction.run()
    local cfg = actionCfg.run[JoinName.thigh]
    local speed = cfg[JoinSpringKeys.speed]
    local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
    local min = csSelf[cfg[JoinSpringKeys.min]]
    local max = csSelf[cfg[JoinSpringKeys.max]]
    local mode = cfg[JoinSpringKeys.mode]
    local times = cfg[JoinSpringKeys.times]
    local spring = cfg[JoinSpringKeys.spring]
    local from = cfg[JoinSpringKeys.from]
    local to = cfg[JoinSpringKeys.to]
    leftThigh:spring(spring, from, to, speed, curve, min, max, mode, times, nil, nil)
    rightThigh:spring(spring, to, from, speed, curve, min, max, mode, times, nil, nil)
end

function GrRoleAction.walk()
    GrRoleAction.walkrightFinish(false)
end

function GrRoleAction.walkleftFinish(reverse)
    local cfg = actionCfg.walk[JoinName.thigh]
    local speed = cfg[JoinSpringKeys.speed]
    local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
    local min = csSelf[cfg[JoinSpringKeys.min]]
    local max = csSelf[cfg[JoinSpringKeys.max]]
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
    leftThigh:spring(spring, from, to, speed, curve, min, max, mode, times, GrRoleAction.walkrightFinish, (not reverse))
end

function GrRoleAction.walkrightFinish(reverse)
    local cfg = actionCfg.walk[JoinName.thigh]
    local speed = cfg[JoinSpringKeys.speed]
    local curve = csSelf.curves[cfg[JoinSpringKeys.curve]]
    local min = csSelf[cfg[JoinSpringKeys.min]]
    local max = csSelf[cfg[JoinSpringKeys.max]]
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
    rightThigh:spring(spring, from, to, speed, curve, min, max, mode, times, GrRoleAction.walkleftFinish, (not reverse))
end
--------------------------------------------
return GrRoleAction
