require("role.GrRolebase")
GrGame = {}

local csSelf = nil
local transform = nil
local isInited = false
local smoothFollow
GrGame.player = nil
GrGame.isPaused = false
GrGame.npcs = {}


-- 初始化，只会调用一次
function GrGame.init(data, callback)
    GrGame._init()

    for i = 1, 1 do
        csSelf:invoke4Lua(function()
            GrGame.loadRole("role1", Vector3.zero,
                    function(role)
                        if role.luaTable == nil then
                            role.luaTable = GrRolebase.new()
                        end
                        role.luaTable:init(role, { isPlayer = false })
                        role.luaTable:goAround()
                        GrGame.npcs[role.instanceID] = role.luaTable
                    end)
        end, 3 * (i - 1))
    end

    GrGame.loadRole("role1", Vector3(5, 0, 5),
            function(role)
                if role.luaTable == nil then
                    role.luaTable = GrRolebase.new()
                end
                GrGame.player = role.luaTable
                GrGame.player:init(role, { isPlayer = true })
                smoothFollow.target = GrGame.player.transform
                Utl.doCallback(callback)
            end)
end

function GrGame._init()
    if isInited then
        return
    end
    isInited = true
    local go = GameObject("game")
    csSelf = go:AddComponent(typeof(CLCellLua))
    transform = go.transform
    transform.parent = MyMain.self.transform
    transform.localPosition = Vector3.zero
    transform.localScale = Vector3.one
    smoothFollow = MyCfg.self.mainCamera:GetComponent("CLSmoothFollow")
    csSelf.luaTable = GrGame
    csSelf:initLuaFunc()


end

function GrGame.loadRole(name, pos, callback)
    CLRolePool.borrowObjAsyn(name,
            function(name, role, orgs)
                role.transform.parent = transform
                role.transform.localScale = Vector3.one
                role.transform.localPosition = pos
                SetActive(role.gameObject, true)
                Utl.doCallback(callback, role)
            end)
end

function GrGame.clean()
    if GrGame.player then
        CLRolePool.returnObj(GrGame.player.csSelf)
        SetActive(GrGame.player.gameObject, false)
        GrGame.player = nil
    end

    for k, v in pairs(GrGame.npcs) do
        CLRolePool.returnObj(v.csSelf)
        SetActive(v.gameObject, false)
    end
    GrGame.npcs = {}
end

function GrGame.onPressJoy(isPressed)
    if isPressed then
        if NumEx.NextBool() then
            GrGame.player:setAction("walk")
        else
            GrGame.player:setAction("run")
        end
    else
        GrGame.player:setAction("idel")
        --if (SCfg.self.player.roleAction.currActionValue == LuaUtl.getAction("run")) then
        --    SCfg.self.player:_setAction("idel");
        --end
        --SCfg.self.player.tween:stopMoveForward();
        --SCfg.self.player.aiPath:stopPathFinding();
        GrGame.player:onArrive()
    end
end

function GrGame.onDragJoy(dragDetla)
    if GrGame.isPaused then
        return
    end
    local dir = dragDetla
    dir = Vector3(dir.x, 0, dir.y)
    if GrGame.player.gameObject.activeInHierarchy then
        Utl.RotateTowards(GrGame.player.transform, dir)
        --GrGame.player:moveForward(dir)
    end
end

function GrGame.getFreePos()
    return Vector3(NumEx.NextInt(-20, 20), 0, NumEx.NextInt(-20, 20))
end

--------------------------------------------
return GrGame
