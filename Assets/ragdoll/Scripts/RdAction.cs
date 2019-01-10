﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RdAction : MonoBehaviour
{
    public AnimationCurve curve;

    public Transform root;//根节点
    public RdJoint head;//头
    public RdJoint spine;//脊柱
    public RdJoint leftUpperArm;//左上臂
    public RdJoint leftForeArm;//左前臂
    public RdJoint leftThigh; //左大腿
    public RdJoint leftCalf;//左小腿
    public RdJoint leftFoot;//左脚
    public RdJoint rightUpperArm;//右上臂
    public RdJoint rightForeArm;//右前臂
    public RdJoint rightThigh; //右大腿
    public RdJoint rightCalf;//右小腿
    public RdJoint rightFoot;//右脚

    private void Start()
    {
        leftThigh.spring(600, -60, 60, 5, curve, -60, 90, true, null);
        rightThigh.spring(600, 60, -60, 5, curve, -60, 90, true, null);
    }

    // Update is called once per frame
    /*
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
        if(targetPos > 45 && flag > 0)
        {
            flag = -1;
        }
        else if(targetPos < -45 && flag < 0)
        {
            flag = 1;
        }
        targetPos += Time.deltaTime * 100 * flag;
        swingThigh(targetPos, leftThigh, false);
        swingThigh(targetPos*-1, rightThigh, true);
    }

    public void swingThigh(float targetPos, HingeJoint thigh, bool inverse)
    {
        JointSpring js = thigh.spring;
        js.targetPosition = targetPos;
        if (js.targetPosition > 180)
        {
            js.targetPosition = js.targetPosition - 360;
        }
        js.targetPosition = Mathf.Clamp(js.targetPosition, thigh.limits.min + 5, thigh.limits.max - 5);
        //if(inverse)
        //{
        //    js.targetPosition = js.targetPosition;
        //}
        thigh.spring = js;
    }
    */
}
