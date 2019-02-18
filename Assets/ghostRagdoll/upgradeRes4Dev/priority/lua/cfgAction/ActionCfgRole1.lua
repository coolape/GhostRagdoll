local ActionCfgRole1 = {
    walk = {
        [JoinName.thigh] = {
            [JoinSpringKeys.spring] = 600,
            [JoinSpringKeys.from] = -30,
            [JoinSpringKeys.to] = 20,
            [JoinSpringKeys.speed] = 5,
            [JoinSpringKeys.curve] = 0,
            [JoinSpringKeys.mode] = JoinSpringMode.once,
            [JoinSpringKeys.times] = 0,
            [JoinSpringKeys.min] = -60,
            [JoinSpringKeys.max] = 90,

        }
    },
    run = {
        [JoinName.thigh] = {
            [JoinSpringKeys.spring] = 600,
            [JoinSpringKeys.from] = -60,
            [JoinSpringKeys.to] = 60,
            [JoinSpringKeys.speed] = 5,
            [JoinSpringKeys.curve] = 0,
            [JoinSpringKeys.mode] = JoinSpringMode.pingpong,
            [JoinSpringKeys.times] = 0,
            [JoinSpringKeys.min] = -60,
            [JoinSpringKeys.max] = 90,
        }
    },
    idel = {
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
}

--------------------------------------------
return ActionCfgRole1
