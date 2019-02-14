GrGame = {}

local csSelf = nil
local transform = nil
local isInited = false
GrGame.player = nil


-- 初始化，只会调用一次
function GrGame.init(data, callback)
    GrGame._init()
    GrGame.loadRole("role1", Vector3.zero, nil, callback)
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
    csSelf.luaTable = GrGame
    csSelf:initLuaFunc()
end

function GrGame.loadRole(name, pos, orgs, callback)
    CLRolePool.borrowObjAsyn(name,
            function(name, role, orgs)
                GrGame.player = role
                GrGame.player.transform.parent = transform
                GrGame.player.transform.localScale = Vector3.one
                GrGame.player.transform.localPosition = pos
                SetActive(GrGame.player.gameObject, true)
                Utl.doCallback(callback, orgs)
            end)
end

function GrGame.clean()
    if GrGame.player then
        CLRolePool.returnObj(GrGame.player)
        SetActive(GrGame.player.gameObject, false)
        GrGame.player = nil
    end
end

--------------------------------------------
return GrGame
