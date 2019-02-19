require("role.GrRolebase")
GrGame = {}

local csSelf = nil
local transform = nil
local isInited = false
local smoothFollow
GrGame.player = nil
GrGame.isPaused = false


-- 初始化，只会调用一次
function GrGame.init(data, callback)
    GrGame._init()
    GrGame.loadRole("role1", Vector3.zero,
            function(role)
                if role.luaTable == nil then
                    role.luaTable = GrRolebase.new()
                end
                GrGame.player = role.luaTable
                GrGame.player:init(role, {})
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
        CLRolePool.returnObj(GrGame.player)
        SetActive(GrGame.player.gameObject, false)
        GrGame.player = nil
    end
end

function GrGame.onPressJoy(isPressed)
    if isPressed then
        GrGame.player:setAction("walk")
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

--------------------------------------------
return GrGame
