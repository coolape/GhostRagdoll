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
            if (time >= 1)
            {
                if (isLoop)
                {
                    flag = -1;
                }
                else
                {
                    //finish
                    playSpring = false;
                    Utl.doCallback(finishCallback, this);
                }
            } else if(time <= 0)
            {
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
    float time = 0;
    JointSpring jspring;
    bool isLoop = false;
    float curveVal = 0;
    bool playSpring = false;
    int flag = 1;

    public void spring(float spring, float fromVal, float targetVal, float speed,
     AnimationCurve curve, float limitMin, float limitMax, bool isLoop, object finishCallback)
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
        this.isLoop = isLoop;
        this.finishCallback = finishCallback;
        flag = 1;
        time = 0;
        jspring = joint.spring;
        jspring.spring = spring;
        playSpring = true;
    }
}
