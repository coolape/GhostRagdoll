GrGame = {}

local csSelf = nil
local transform = nil
local isInited = false


-- 初始化，只会调用一次
function GrGame.init(data, callback)
    GrGame._init()
    Utl.doCallback(callback)
end

function GrGame._init()
    if isInited then
        return
    end
    isInited = true
    local go = GameObject("game")
    csSelf = go:AddComponent(typeof(CLCellLua))
    transform = go.transform
    csSelf.luaTable = GrGame
    csSelf:initLuaFunc()
end




--------------------------------------------
return GrGame
