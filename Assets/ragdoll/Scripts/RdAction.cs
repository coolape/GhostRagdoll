using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RdAction : MonoBehaviour
{
    public Transform root;//根节点
    public HingeJoint head;//头
    public CharacterJoint spine;//脊柱
    public CharacterJoint leftUpperArm;//左上臂
    public CharacterJoint leftForeArm;//左前臂
    public HingeJoint leftThigh; //左大腿
    public HingeJoint leftCalf;//左小腿
    public HingeJoint leftFoot;//左脚
    public CharacterJoint rightUpperArm;//右上臂
    public CharacterJoint rightForeArm;//右前臂
    public HingeJoint rightThigh; //右大腿
    public HingeJoint rightCalf;//右小腿
    public HingeJoint rightFoot;//右脚

    // Update is called once per frame
    void Update()
    {
        walk();
    }
    float targetPos = 90;
    int flag = 1;
    public void walk()
    {
        leftThigh.useMotor = false;
        rightThigh.useMotor = false;
        leftThigh.useSpring = true;
        rightThigh.useSpring = true;
        if(targetPos > 270 && flag > 0)
        {
            flag = -1;
        }
        else if(targetPos < 90 && flag < 0)
        {
            flag = 1;
        }
        targetPos += Time.deltaTime * 10 * flag;
        swingThigh(targetPos, leftThigh, false);
        swingThigh(targetPos, rightThigh, true);
    }

    public void swingThigh(float targetPos, HingeJoint thigh, bool inverse)
    {
        JointSpring js = thigh.spring;
        js.targetPosition = targetPos;
        //if (js.targetPosition > 180)
        //{
        //    js.targetPosition = js.targetPosition - 360;
        //}
        js.targetPosition = Mathf.Clamp(js.targetPosition, thigh.limits.min + 5, thigh.limits.max - 5);
        if(inverse)
        {
            js.targetPosition = js.targetPosition * -1;
        }
        thigh.spring = js;
    }
}
