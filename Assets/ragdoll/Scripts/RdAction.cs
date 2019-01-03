using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RdAction : MonoBehaviour
{
    public HingeJoint headJoint;
    public HingeJoint leftLeg;
    public HingeJoint rightLeg;


    // Update is called once per frame
    void Update()
    {

    }
    public void walk()
    {
        leftLeg.useMotor = false;
        rightLeg.useMotor = false;
        leftLeg.useSpring = true;
        rightLeg.useSpring = true;

        JointSpring js = leftLeg.spring;
        if(js.targetPosition > 180)
        {
            js.targetPosition = js.targetPosition - 360;
        }
        js.targetPosition = Mathf.Clamp(js.targetPosition, leftLeg.limits.min +5, leftLeg.limits.max - 5 );
        leftLeg.spring = js;
    }
}
