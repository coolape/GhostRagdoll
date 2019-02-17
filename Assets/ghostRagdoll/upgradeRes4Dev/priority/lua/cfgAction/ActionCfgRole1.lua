local ActionCfgRole1 = {
    walk = {
        [JoinSpringKeys.spring] = 600,
        [JoinSpringKeys.from] = -30,
        [JoinSpringKeys.to] = 20,
        [JoinSpringKeys.speed] = 5,
        [JoinSpringKeys.curve] = 1,
        [JoinSpringKeys.mode] = JoinSpringMode.once,
        [JoinSpringKeys.times] = 0,
    },
    run = {
        [JoinSpringKeys.spring] = 600,
        [JoinSpringKeys.from] = -30,
        [JoinSpringKeys.to] = 20,
        [JoinSpringKeys.speed] = 5,
        [JoinSpringKeys.curve] = 1,
        [JoinSpringKeys.mode] = JoinSpringMode.pingpong,
        [JoinSpringKeys.times] = 0,
    },
    idel = {
        [JoinSpringKeys.spring] = 600,
        [JoinSpringKeys.from] = 0,
        [JoinSpringKeys.to] = 0,
        [JoinSpringKeys.speed] = 3,
        [JoinSpringKeys.curve] = 1,
        [JoinSpringKeys.mode] = JoinSpringMode.once,
        [JoinSpringKeys.times] = 0,
    }
}

--------------------------------------------
return ActionCfgRole1
