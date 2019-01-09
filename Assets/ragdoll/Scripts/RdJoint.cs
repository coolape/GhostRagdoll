using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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
        
    }

    public void spring(float sping, float targetVal, float speed,
     AnimationCurve curve, float limitMin, float limitMax, object finishCallback)
    {

    }
}
