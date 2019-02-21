local ActionCfgRole1 = {}
ActionCfgRole1.randomSpeed = function()
    return NumEx.NextInt(20, 60) / 10
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


--------------------------------------------
return ActionCfgRole1
