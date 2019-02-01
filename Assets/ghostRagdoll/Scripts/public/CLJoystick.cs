using UnityEngine;
using System.Collections;
using XLua;
using Coolape;

/// <summary>
/// CL joystick.
/// </summary>
[RequireComponent(typeof(BoxCollider))]

public class CLJoystick : UIEventListener
{
    public Transform joystickUI;
    public float joystickMoveDis = 10;
    object onPressCallback;
    object onDragCallback;
    object onClickCallback;
    bool isCanMove = false;
    Vector2 orgPos = Vector2.zero;
    Vector2 dragDetla = Vector2.zero;
    Vector3 joystickUIPos = Vector3.zero;
    //	GameObject empty = null;

    bool isFinishStart = false;
    void Start()
    {
        if (isFinishStart) return;
        isFinishStart = true;
        mainCamera = MyMainCamera.current;
        if (joystickUI != null)
        {
            joystickUI.transform.parent.localScale = Vector3.one * 0.95f;
            joystickUIPos = joystickUI.transform.parent.localPosition;
            orgPos = joystickUI.localPosition;
        }
    }

    public void init(object onPress, object onClick, object onDrag)
    {
        mainCamera = MyMainCamera.current;
        onPressCallback = onPress;
        onDragCallback = onDrag;
        onClickCallback = onClick;
        Start();
        OnPress(false);
    }

    MyMainCamera mainCamera;

    void OnClick()
    {

        mainCamera.enabled = true;
        mainCamera.Update();
        mainCamera.LateUpdate();

        if (onClickCallback != null)
        {
            Utl.doCallback(onClickCallback);
        }
    }

    void OnPress(bool isPressed)
    {
        if (!isPressed)
        {
            if (isCanMove)
            {
                callOnPressCallback(isPressed);
            }
            isCanMove = false;
            dragDetla = Vector2.zero;
            if (joystickUI != null)
            {
                joystickUI.localPosition = orgPos;
                joyPosition = orgPos;
                joystickUI.transform.parent.localPosition = joystickUIPos;
                joystickUI.transform.parent.localScale = Vector3.one * 0.95f;
            }
        }
        else
        {
            joyPosition = orgPos;
            joystickUI.transform.parent.localScale = Vector3.one * 1.1f;
            doOnPress();
        }
    }

    void callOnPressCallback(bool isPressed)
    {
        Utl.doCallback(onPressCallback, isPressed);
    }

    void doOnPress()
    {
        joystickUI.transform.parent.position = UICamera.lastHit.point;
        callOnPressCallback(true);
    }

    Vector3 joyPosition = Vector3.zero;
    void OnDrag(Vector2 delta)
    {
        isCanMove = true;
        joyPosition += new Vector3(delta.x, delta.y, 0);
        if (joyPosition.magnitude > joystickMoveDis)
        {
            joystickUI.transform.localPosition = Vector3.ClampMagnitude(joyPosition, joystickMoveDis);
        }
        else
        {
            joystickUI.transform.localPosition = joyPosition;
        }
        dragDetla = new Vector2((joystickUI.transform.localPosition.x - orgPos.x) / joystickMoveDis, (joystickUI.transform.localPosition.y - orgPos.y) / joystickMoveDis);
    }


    //	void  OnDragOver (GameObject draggedObject) //is sent to a game object when another object is dragged over its area.
    //	{
    //		Debug.LogError("OnDragOver");
    //		OnPress(false);
    //	}
    //	void  OnDragOut (GameObject draggedObject) //is sent to a game object when another object is dragged out of its area.
    //	{
    //		Debug.LogError("OnDragOut");
    //		OnPress(false);
    //	}

    void OnDragEnd()// is sent to a dragged object when the drag event finishes.
    {
        OnPress(false);
    }

    void OnDoubleClick()
    {

    }

#if UNITY_EDITOR || UNITY_STANDALONE_WIN || UNITY_STANDALONE_OSX
    //LuaFunction _lfonPressAttack;
    //LuaFunction _lfonPressSkill;
    //LuaFunction lfonPressAttack{
    //	get{
    //		if(_lfonPressAttack == null) {
    //			_lfonPressAttack = (LuaFunction)(Utl.getLuaVar(Main.self.lua, "PanelBattle", "onPressAttack"));
    //		}
    //		return _lfonPressAttack;
    //	}
    //}
    //LuaFunction lfonPressSkill{
    //	get{
    //		if(_lfonPressSkill == null) {
    //			_lfonPressSkill = (LuaFunction)(Utl.getLuaVar(Main.self.lua, "PanelBattle", "playSkillByIndex"));
    //		}
    //		return _lfonPressSkill;
    //	}
    //}
#endif
    void Update()
    {
        if (isCanMove)
        {
            Utl.doCallback(onDragCallback, dragDetla);
        }

#if UNITY_EDITOR || UNITY_STANDALONE_WIN || UNITY_STANDALONE_OSX
        if (Input.GetKey(KeyCode.W) && Input.GetKey(KeyCode.D))
        {
            isCanMove = true;
            dragDetla = new Vector2(1, 1);
        }
        else if (Input.GetKey(KeyCode.W) && Input.GetKey(KeyCode.A))
        {
            isCanMove = true;
            dragDetla = new Vector2(-1, 1);
        }
        else if (Input.GetKey(KeyCode.W) && Input.GetKey(KeyCode.S))
        {
            isCanMove = true;
            dragDetla = new Vector2(0, 1);
        }
        else if (Input.GetKey(KeyCode.S) && Input.GetKey(KeyCode.D))
        {
            isCanMove = true;
            dragDetla = new Vector2(1, -1);
        }
        else if (Input.GetKey(KeyCode.S) && Input.GetKey(KeyCode.A))
        {
            isCanMove = true;
            dragDetla = new Vector2(-1, -1);
        }
        else if (Input.GetKey(KeyCode.A) && Input.GetKey(KeyCode.D))
        {
            isCanMove = true;
            dragDetla = new Vector2(1, 0);
        }
        else if (Input.GetKey(KeyCode.W))
        {
            isCanMove = true;
            dragDetla = new Vector2(0, 1);
        }
        else if (Input.GetKey(KeyCode.S))
        {
            isCanMove = true;
            dragDetla = new Vector2(0, -1);
        }
        else if (Input.GetKey(KeyCode.A))
        {
            isCanMove = true;
            dragDetla = new Vector2(-1, 0);
        }
        else if (Input.GetKey(KeyCode.D))
        {
            isCanMove = true;
            dragDetla = new Vector2(1, 0);
        }

        if (Input.GetKeyUp(KeyCode.A) ||
           Input.GetKeyUp(KeyCode.D) ||
           Input.GetKeyUp(KeyCode.W) ||
           Input.GetKeyUp(KeyCode.S)
           )
        {
            isCanMove = false;

            Utl.doCallback(onPressCallback, false);
        }

        //if(Input.GetKeyDown(KeyCode.J)) {
        //	if (lfonPressAttack != null) {
        //		lfonPressAttack.Call(null, true);
        //	}
        //} else if(Input.GetKeyUp(KeyCode.J)) {
        //	if (lfonPressAttack != null) {
        //		lfonPressAttack.Call(null, false);
        //	}
        //}
        //if(Input.GetKeyUp(KeyCode.U)) {
        //	if(lfonPressSkill != null)
        //		lfonPressSkill.Call(1);
        //} else if(Input.GetKeyUp(KeyCode.I)) {
        //	if(lfonPressSkill != null)
        //		lfonPressSkill.Call(2);
        //} else if(Input.GetKeyUp(KeyCode.O)) {
        //	if(lfonPressSkill != null)
        //		lfonPressSkill.Call(3);
        //} else if(Input.GetKeyUp(KeyCode.P)) {
        //	if(lfonPressSkill != null)
        //		lfonPressSkill.Call(4);
        //} else if(Input.GetKeyUp(KeyCode.N)) {
        //	if(lfonPressSkill != null)
        //		lfonPressSkill.Call(7);
        //} else if(Input.GetKeyUp(KeyCode.M)) {
        //	if(lfonPressSkill != null)
        //		lfonPressSkill.Call(8);
        //} else if(Input.GetKeyUp(KeyCode.B)) {
        //	if(lfonPressSkill != null)
        //		lfonPressSkill.Call(9);
        //} else if(Input.GetKeyUp(KeyCode.H)) {
        //	if(lfonPressSkill != null)
        //		lfonPressSkill.Call(10);
        //}
#endif
    }

}
