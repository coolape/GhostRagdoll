using UnityEngine;
using System.Collections;
using Coolape;

public class RdAIPath : CLSeekerByRay
{

    public void moveTo(Vector3 pos)
    {
        seek(pos);
    }

    bool finishOneSubPath = false;
    Vector3 fromPos4Moving = Vector3.zero;
    Vector3 diff4Moving = Vector3.zero;
    int nextPahtIndex = 0;
    public override void startMove()
    {
        canMove = false;
        if (pathList == null || pathList.Count < 2)
        {
            Debug.LogWarning("Path list error!");
            return;
        }
        if (Vector3.Distance(mTransform.position, pathList[0]) < 0.001f)
        {
            //说明是在原点
            finishOneSubPath = false;
            fromPos4Moving = pathList[0];
            diff4Moving = pathList[1] - pathList[0];
            nextPahtIndex = 1;
            rotateTowards(diff4Moving, true);
            canMove = true;
        }
        else if (Vector3.Distance(mTransform.position, pathList[pathList.Count - 1]) <= endReachedDistance)
        {
            //到达目标点
            Utl.doCallback(onFinishSeekCallback);
            return;
        }
        else
        {
            float dis = 0;
            float dis1 = 0;
            float dis2 = 0;
            for (int i = 1; i < pathList.Count; i++)
            {
                dis = Vector3.Distance(pathList[i - 1], pathList[i]);
                dis1 = Vector3.Distance(mTransform.position, pathList[i - 1]);
                dis2 = Vector3.Distance(mTransform.position, pathList[i]);
                if (Mathf.Abs(dis - (dis1 + dis2)) < 0.001f)
                {
                    finishOneSubPath = false;
                    nextPahtIndex = i;
                    fromPos4Moving = pathList[i - 1];
                    diff4Moving = pathList[i] - pathList[i - 1];
                    rotateTowards(diff4Moving, true);
                    canMove = true;
                    break;
                }
            }
        }
    }

    void checkNextPoint()
    {
        if(Vector3.Distance(pathList[nextPahtIndex], transform.position) < endReachedDistance)
        {
            nextPahtIndex++;
            if(nextPahtIndex >= pathList.Count)
            {
                canMove = false;
                //到达目标点
                Utl.doCallback(onFinishSeekCallback);
            }
            else
            {
                fromPos4Moving = pathList[nextPahtIndex - 1];
                diff4Moving = pathList[nextPahtIndex] - fromPos4Moving;
                rotateTowards(diff4Moving, true);
            }
        }
    }

    public override void Update()
    {
        //base.Update();
        if (canMove && movingBy == MovingBy.Update)
        {
            checkNextPoint();
        }
    }

    public override void FixedUpdate()
    {
        //base.FixedUpdate();
        if (canMove && movingBy == MovingBy.FixedUpdate)
        {
            checkNextPoint();
        }
    }

}
