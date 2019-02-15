
require("public.class")

GrRolebase = class("GrRolebase")

function GrRolebase:ctor(param)
    GrRolebase.gameObject = nil
end

function GrRolebase:init(csSelf, param)
    GrGame.gameObject = csSelf.gameObject
end
--------------------------------------------
return GrRolebase
