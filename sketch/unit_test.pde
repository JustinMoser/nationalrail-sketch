////import polymonkey.time.*;
//
//PApplet appl;
//HashMap trainMap;
//
////
//// class TestTrain
////
//Time m_time;
//class TestTrain
//{
//
//    TimerEvent m_timer;
//    String m_trainName;
//    PApplet m_applet;
//    TestTrain( PApplet applet, HashMap trains, String trainName )
//    {
//        if( m_time == null )
//        {
//            m_time = new Time( applet );
//        }
//        m_trainName = trainName;
//        m_applet = applet;
//        m_timer = new TimerEvent( applet, m_time, 1.0 );
//        trains.put(m_timer,this);
//        println("TestTrain::TestTrain Name:" + m_trainName);
//    }
//    void timerEvent()
//    {
//        Point p = getTrainPosition(now());
//        println("TestTrain x=" + p.getX() + " y=" + p.getY());
//        println("TestTrain::timerEvent Name:" + m_trainName);
//    }
//    Point getTrainPosition(float t)
//    {
//        Point p1 = new Point(0,0);
//        float t1 = 0.0;
//        Point p2 = new Point(100,100);
//        float t2 = 24.0;
//        println("getTrainPosition called at " + t);
//        //
//        //
//        //
//        //
//        //
//        //
//        //
//        //
//        float ratio = (t-t1)/(t2-t1);
//        float x = p1.getX() + ratio *(p2.getX() - p1.getX());
//        float y = p1.getY() + ratio *(p2.getY() - p1.getY());
//        return new Point(x,y);
//
//    }
//
//    float now()
//    {
//        float h = hour();
//        float m = minute();
//        float s = second();
//
//        return h + m/60 + s/3600; 
//    }
//}
////
//
//void timerEvent(TimerEvent sw)
//{
//    TestTrain train = (TestTrain)trainMap.get(sw);
//    /*
//  println("Items in map="+trainMap.size());
//     
//     Iterator i = trainMap.entrySet().iterator();  // Get an iterator
//     while (i.hasNext()) 
//     {
//     Map.Entry me = (Map.Entry)i.next();
//     print(me.getKey() + " is ");
//     println(me.getValue());
//     } 
//     */
//    train.timerEvent();
//}
//
//class Point
//{
//    float m_x;
//    float m_y;
//    Point(float x, float y)
//    {
//        m_x = x;
//        m_y = y;
//    }
//    float getX()
//    {
//        return m_x;
//    }
//    float getY()
//    {
//        return m_y;
//    }
//}
//
//
//
//void setup()
//{
//    appl = this;
//    trainMap = new HashMap();
//    TestTrain t1 = new TestTrain(appl,trainMap,"StartTrain");
//    //TestTrain t2 = new TestTrain(appl,trainMap,"SecondTrain");
//    //TestTrain t3 = new TestTrain(appl,trainMap,"ThirdTrain");
//
//}
//
//void draw()
//{
//}
//
//
//
//

