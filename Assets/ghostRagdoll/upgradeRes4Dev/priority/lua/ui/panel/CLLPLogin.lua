-- 用户登陆界面
do
    ---@type NetProtoUsermgr
    local NetProtoUsermgr = require("net.NetProtoUsermgrClient")
    CLLPLogin = {}

    local csSelf = nil
    local transform = nil
    local ButtonEntry
    local ButtonServer
    local LabelServerName
    local LabelServerState
    local loginContent
    local oldServerIdx
    local user
    local server
    local finishCallback

    -- 初始化，只会调用一次
    function CLLPLogin.init(csObj)
        csSelf = csObj
        transform = csObj.transform
        --[[
        上的组件：getChild(transform, "offset", "Progress BarHong"):GetComponent("UISlider")
        --]]
        local bottom = getChild(transform, "AnchorBottom/offset")
        ButtonEntry = getChild(bottom, "ButtonEntry").gameObject
        ButtonServer = getChild(bottom, "ButtonServer")
        LabelServerName = getCC(ButtonServer, "LabelName", "UILabel")
        LabelServerState = getCC(ButtonServer, "LabelState", "UILabel")
        ButtonServer = ButtonServer.gameObject
        loginContent = getChild(transform, "loginContent")
        -- 网络
        Net.self:setLua()
    end

    -- 设置数据
    function CLLPLogin.setData(paras)
        finishCallback = paras
    end

    -- 显示，在c#中。show为调用refresh，show和refresh的区别在于，当页面已经显示了的情况，当页面再次出现在最上层时，只会调用refresh
    function CLLPLogin.show()
        SetActive(ButtonEntry, false)
        SetActive(ButtonServer, false)
        SetActive(loginContent.gameObject, true)
    end

    -- 刷新
    function CLLPLogin.refresh()
    end

    -- 关闭页面
    function CLLPLogin.hide()
    end

    function CLLPLogin.setServer(data)
        server = data
        LabelServerName.text = server.name
        local state = bio2number(server.status)
        LabelServerState.text = (state == 1 and "[00ffff]正常[-]" or (state == 2 and "[00ff00]爆满[-]" or "[fff0000]维护[-]"))
        SetActive(ButtonServer, true)
    end

    -- 网络请求的回调；cmd：指命，succ：成功失败，msg：消息；paras：服务器下行数据
    function CLLPLogin.procNetwork (cmd, succ, msg, paras)
        if succ == NetSuccess then
            if cmd == NetProtoUsermgr.cmds.loginAccountChannel
                    or cmd == NetProtoUsermgr.cmds.loginAccount
                    or cmd == NetProtoUsermgr.cmds.registAccount then
                hideHotWheel()
                user = paras.userInfor
                NetProtoUsermgr.__sessionID = bio2Int(paras.userInfor.idx)
                -- 初始化时间
                DateEx.init(bio2number(paras.systime))
                -- 取得服务器
                oldServerIdx = bio2number(paras.serverid)
                if oldServerIdx > 0 then
                    showHotWheel()
                    CLLNet.httpPostUsermgr(NetProtoUsermgr.send.getServerInfor(oldServerIdx))
                else
                    printw("get the server id == 0")
                end
            elseif cmd == NetProtoUsermgr.cmds.getServerInfor then
                CLLPLogin.setServer(paras.server)
                SetActive(loginContent.gameObject, false)
                SetActive(ButtonEntry, true)
                hideHotWheel()
            end
        else
            hideHotWheel()
            CLAlert.add(msg)
        end
    end

    -- 处理ui上的事件，例如点击等
    function CLLPLogin.uiEventDelegate( go )
        local goName = go.name

        if goName == "ButtonVisitor" then
            local deviceInfor = {}
            table.insert(deviceInfor, SystemInfo.deviceName)
            table.insert(deviceInfor, SystemInfo.deviceModel)
            table.insert(deviceInfor, SystemInfo.deviceType:ToString())
            table.insert(deviceInfor, SystemInfo.operatingSystem)
            table.insert(deviceInfor, SystemInfo.maxTextureSize)
            showHotWheel()
            CLLNet.httpPostUsermgr(NetProtoUsermgr.send.loginAccountChannel(Utl.uuid,
                    CLCfgBase.self.appUniqueID,
                    getChlCode(),
                    Utl.uuid,
                    table.concat(deviceInfor, ",")))
        elseif goName == "ButtonServer" then
            --CLPanelManager.getPanelAsy("PanelServers", onLoadedPanelTT, { CLLPLogin.onSelectServer, selectedServer })
        elseif goName == "ButtonEntry" then
            SetActive(ButtonEntry, false)
            local state = bio2number(server.status)
            if state ~= "1" then
                -- 服务器停服了
                CLAlert.add(LGet("UIMsg005"), Color.red, 1)
                SetActive(ButtonEntry, true)
                return
            end
            hideTopPanel(csSelf)
            if oldServerIdx ~= bio2number(server.idx) then
                -- 保存所选的服务器
                CLLNet.httpPostUsermgr(NetProtoUsermgr.send.setEnterServer(bio2number(server.idx), bio2number(user.idx), CLCfgBase.self.appUniqueID))
            end
            Utl.doCallback(finishCallback, user, server)
        elseif goName == "ButtonXieyi" then
            --CLPanelManager.getPanelAsy("PanelRobotTest", onLoadedPanelTT, { MapEx.getString(user, "idx"), selectedServer })
        elseif goName == "ButtonSetting" then
            --getPanelAsy("PanelSetting", onLoadedPanelTT)
        end
    end

    -- 当按了返回键时，关闭自己（返值为true时关闭）
    function CLLPLogin.hideSelfOnKeyBack( )
        return true
    end

    --------------------------------------------
    return CLLPLogin
end
