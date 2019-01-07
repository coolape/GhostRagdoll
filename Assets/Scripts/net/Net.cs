﻿using UnityEngine;
using System.Collections;
using System.IO;
using System.Text;
using XLua;


namespace Coolape
{
    public class Net : Tcp
    {
        public static Net self;

        public Net()
        {
            self = this;
        }
        public CLBaseLua lua;
        public enum NetWorkType
        {
            publish,
            test1,
            test2,
        }

        public int _SuccessCodeValue = 0;

        // 成功的返回值
        public static int SuccessCode
        {
            get
            {
                return self._SuccessCodeValue;
            }
        }

        [HideInInspector]
        public NetWorkType switchNetType = NetWorkType.publish;
        [HideInInspector]
        public string host4Publish = "";
        [HideInInspector]
        public string host4Test1 = "";
        [HideInInspector]
        public string host4Test2 = "";

        // 默认地址
        string _gateHost;

        public string gateHost
        {     //网关
            get
            {
                switch (switchNetType)
                {
                    case NetWorkType.publish:
                        _gateHost = host4Publish;
                        break;
                    case NetWorkType.test1:
                        _gateHost = host4Test1;
                        break;
                    case NetWorkType.test2:
                        _gateHost = host4Test2;
                        break;
                }
                return _gateHost;
            }
            set
            {
                _gateHost = value;
            }
        }

        public int gatePort;
        //网关
        public int httpPort;
        public string httpFunc = "";

        [XLua.CSharpCallLua]
        public delegate void __DispatchGame(object data);
        __DispatchGame dispatchGame;
        [XLua.CSharpCallLua]
        public delegate void TcpPackMessageAndSendFunc(object obj, Tcp tcp);
        TcpPackMessageAndSendFunc packMsgFunc;
        [XLua.CSharpCallLua]
        public delegate object TcpUnpackMessageFunc(MemoryStream buffer, Tcp tcp);
        TcpUnpackMessageFunc unPackMsgFunc;
        //=====================begain===================
        public void setLua()
        {
            lua.setLua();
            dispatchGame = lua.luaTable.GetInPath<__DispatchGame>("dispatchGame");
            packMsgFunc = lua.luaTable.GetInPath<TcpPackMessageAndSendFunc>("packMsg");
            unPackMsgFunc = lua.luaTable.GetInPath<TcpUnpackMessageFunc>("unpackMsg");
        }

        //===================end=====================
        public void connect(string host, int port)
        {
            StartCoroutine(doConnect(host, port));
        }

        IEnumerator doConnect(string host, int port)
        {
            yield return null;
            init(host, port, (TcpDispatchDelegate)dispatchData);
            base.connect();
        }

        public void dispatchData(object data, Tcp tcp)
        {
            if (dispatchGame != null)
            {
                dispatchGame(data);
            }
        }

        public override byte[] encodeData(object obj)
        {
            packMsgFunc(obj, this);
            return null;
        }

        public override object parseRecivedData(MemoryStream buffer)
        {
            return unPackMsgFunc(buffer, this);
        }
    }
}
