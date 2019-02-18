using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Coolape;

public class RdJoint : MonoBehaviour
{

    HingeJoint _joint;
    public HingeJoint joint
    {
        get
        {
            if(_joint == null)
            {
                _joint = GetComponent<HingeJoint>();
            }
            return _joint;
        }
    }


    // Update is called once per frame
    void Update()
    {
        if (playSpring)
        {
            time += Time.deltaTime * speed* flag;
            curveVal = curve.Evaluate(Mathf.Clamp(time, 0, 1));
            jspring.targetPosition = fromVal + curveVal * diffVal;
            joint.spring = jspring;
            if (time >= 1) {
                runTimes++;
                if (mode == "pingpong")
                {
                    flag = -1;
                } else if(mode == "loop")
                {
                    flag = 1;
                    time = 0;
                }
                else
                {
                    //finish
                    playSpring = false;
                    Utl.doCallback(finishCallback, this, callbackParam);
                }
                if(springTimes > 0 && runTimes >= springTimes)
                {
                    playSpring = false;
                    Utl.doCallback(finishCallback, this, callbackParam);
                }
            } else if(time <= 0) {
                flag = 1;
            }
        }
    }

    float diffVal = 0;
    float fromVal = 0;
    float targetVal = 0;
    float speed = 1;
    AnimationCurve curve;
    object finishCallback;
    object callbackParam;
    float time = 0;
    JointSpring jspring;
    string mode = "once";
    float curveVal = 0;
    int springTimes = 0;
    int runTimes = 0;
    bool playSpring = false;
    int flag = 1;

    public void spring(float springVal, float targetVal, float speed,
     AnimationCurve curve, float limitMin, float limitMax, string mode, int springTimes, object finishCallback, object callbackParam)
    {
        jspring = joint.spring;
        spring(springVal, jspring.targetPosition, targetVal, speed,
     curve, limitMin, limitMax, mode, springTimes, finishCallback, callbackParam);
    }
        public void spring(float springVal, float fromVal, float targetVal, float speed,
     AnimationCurve curve, float limitMin, float limitMax, string mode, int springTimes, object finishCallback, object callbackParam)
    {
        joint.useSpring = true;
        JointLimits limits = joint.limits;
        limits.min = limitMin;
        limits.max = limitMax;
        joint.limits = limits;
        diffVal = targetVal - fromVal;
        this.speed = speed;
        this.curve = curve;
        this.fromVal = fromVal;
        this.targetVal = targetVal;
        this.mode = mode;
        this.springTimes = springTimes;
        this.finishCallback = finishCallback;
        this.callbackParam = callbackParam;
        flag = 1;
        time = 0;
        runTimes = 0;
        jspring = joint.spring;
        jspring.spring = springVal;
        playSpring = true;
    }

    public void stop()
    {
        playSpring = false;
    }
}
