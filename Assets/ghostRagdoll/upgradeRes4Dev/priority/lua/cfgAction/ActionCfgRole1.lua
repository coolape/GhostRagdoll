local ActionCfgRole1 = {}
local speedChgTime = 0
local speed = 1
ActionCfgRole1.randomSpeed = function()
    if speedChgTime < DateEx.nowMS then
        speedChgTime = DateEx.nowMS + 30000
        speed = NumEx.NextInt(20, 50) / 10
    end
    return speed
end

ActionCfgRole1.walk = {
    [JoinName.thigh] = {
        [JoinSpringKeys.spring] = 600,
        [JoinSpringKeys.from] = -40,
        [JoinSpringKeys.to] = 20,
        [JoinSpringKeys.speed] = ActionCfgRole1.randomSpeed, --2
        [JoinSpringKeys.curve] = 0,
        [JoinSpringKeys.mode] = JoinSpringMode.once,
        [JoinSpringKeys.times] = 0,
        [JoinSpringKeys.min] = -60,
        [JoinSpringKeys.max] = 90,

    }
}
ActionCfgRole1.run = {
    [JoinName.thigh] = {
        [JoinSpringKeys.spring] = 600,
        [JoinSpringKeys.from] = -60,
        [JoinSpringKeys.to] = 60,
        [JoinSpringKeys.speed] = ActionCfgRole1.randomSpeed, --4,
        [JoinSpringKeys.curve] = 0,
        [JoinSpringKeys.mode] = JoinSpringMode.pingpong,
        [JoinSpringKeys.times] = 0,
        [JoinSpringKeys.min] = -60,
        [JoinSpringKeys.max] = 90,
    }
}
ActionCfgRole1.idel = {
    [JoinName.thigh] = {
        [JoinSpringKeys.spring] = 600,
        [JoinSpringKeys.from] = 0,
        [JoinSpringKeys.to] = 0,
        [JoinSpringKeys.speed] = 3,
        [JoinSpringKeys.curve] = 0,
        [JoinSpringKeys.mode] = JoinSpringMode.once,
        [JoinSpringKeys.times] = 0,
        [JoinSpringKeys.min] = -60,
        [JoinSpringKeys.max] = 90,
    }
}

ActionCfgRole1.push = {
    [JoinName.leftUpperArm] = {
        [JoinSpringKeys.spring] = 600,
        [JoinSpringKeys.from] = 0,
        [JoinSpringKeys.to] = 100,
        [JoinSpringKeys.speed] = 1,
        [JoinSpringKeys.curve] = 0,
        [JoinSpringKeys.mode] = JoinSpringMode.pingpong,
        [JoinSpringKeys.times] = 1,
        [JoinSpringKeys.min] = 0,
        [JoinSpringKeys.max] = 100,
    },
    [JoinName.rightUpperArm] = {
        [JoinSpringKeys.spring] = 600,
        [JoinSpringKeys.from] = 0,
        [JoinSpringKeys.to] = 100,
        [JoinSpringKeys.speed] = 1,
        [JoinSpringKeys.curve] = 0,
        [JoinSpringKeys.mode] = JoinSpringMode.pingpong,
        [JoinSpringKeys.times] = 1,
        [JoinSpringKeys.min] = 0,
        [JoinSpringKeys.max] = 100,
    },
    [JoinName.leftForeArm] = {
        [JoinSpringKeys.spring] = 1000,
        [JoinSpringKeys.from] = 130,
        [JoinSpringKeys.to] = 0,
        [JoinSpringKeys.speed] = 1,
        [JoinSpringKeys.curve] = 0,
        [JoinSpringKeys.mode] = JoinSpringMode.pingpong,
        [JoinSpringKeys.times] = 1,
        [JoinSpringKeys.min] = 0,
        [JoinSpringKeys.max] = 135,
    },
    [JoinName.rightForeArm] = {
        [JoinSpringKeys.spring] = 1000,
        [JoinSpringKeys.from] = 130,
        [JoinSpringKeys.to] = 0,
        [JoinSpringKeys.speed] = 1,
        [JoinSpringKeys.curve] = 0,
        [JoinSpringKeys.mode] = JoinSpringMode.pingpong,
        [JoinSpringKeys.times] = 1,
        [JoinSpringKeys.min] = 0,
        [JoinSpringKeys.max] = 135,
    },
}

--------------------------------------------
return ActionCfgRole1
