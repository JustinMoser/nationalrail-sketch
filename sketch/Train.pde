/*import polymonkey.time.*;

Time g_time;

class Train
{
    Route   m_route;
    float   m_totalRouteTime;
    TimerEvent m_timer;
    PApplet m_applet;
    HashMap m_trainsMap;
    float m_startTime;
    boolean m_finished;
    
    Train( Route route, PApplet applet, HashMap trainsMap, float startTime )
    {
        m_route = route;
        trace("Train::Train - " + m_route.getRouteName() );
        m_applet = applet;
        m_totalRouteTime = 0;
        m_trainsMap = trainsMap;
        m_finished = false;
        m_startTime = startTime;
        for( int i = 0 ; i < m_route.getStationCount() ; ++i )
        {
            RouteStation routeStation = m_route.getRoutePoint(i);
            m_totalRouteTime += routeStation.getTimeToNext();
            trace("Train::Train - " + routeStation.getStation().getCode() + " " + routeStation.getTimeToNext() );
        }
        trace("Train::Train - route total time " + m_totalRouteTime);
        startTrain();
    }
    float getStartTime()
    {
        return m_startTime;    
    }
    String getRoutName()
    {
        return m_route.getRouteName();
    }
    void startTrain()
    {
        //m_startTime = now();
        trace("Train::startTrain at " + m_startTime);
        if( g_time == null )
        {
            trace("Train::startTrain creating time object" );
            g_time = new Time( m_applet );
        }
        trace("Train::startTrain creating train timer" );
        m_timer = new TimerEvent( m_applet, g_time, 2.0 );
        trace("Train::startTrain adding train " + m_route.getRouteName()  + " to map" );
        m_trainsMap.put(m_timer,this); 
        trace("Train::startTrain added train " + m_route.getRouteName()  + " to map size = " + m_trainsMap.size());  
    }
    Point timerEvent()
    {
        Point p = getTrainPosition(now());
        trace("Train::timerEvent Name: " + m_route.getRouteName() + " Train x=" + p.getX() + " y=" + p.getY());
        return p;    
    }

    Point getTrainPosition(float atTime)
    {
        float sinceDeparted = atTime-m_startTime;
        sinceDeparted *= 60; // to mins
        if( sinceDeparted >= m_totalRouteTime)
        {
            m_finished = true;
            trace("Train::getTrainPosition = FINISHED!!!");
            m_route.getRoutePoint(m_route.getStationCount()-1).getStation().getPoint();
        }
        RouteStation previousStation = m_route.getRoutePoint(0);
        RouteStation nextStation=m_route.getRoutePoint(1);
        float nextStationTime=0;
        float previousStationTime=0;
        trace("Train::getTrainPosition sinceDeparted=" + sinceDeparted + " at " + atTime);
        for( int i = 0 ; i < m_route.getStationCount() && nextStationTime < sinceDeparted ; ++i )
        {
            trace("Train::getTrainPosition loop = " + i);
            previousStationTime = nextStationTime;
            previousStation = m_route.getRoutePoint(i);
            nextStationTime += previousStation.getTimeToNext();
            if( i < m_route.getStationCount()-1 )
            {
                nextStation = m_route.getRoutePoint(i+1);
            }
            trace("Train::getTrainPosition loop[" + i + "] prevSt="+previousStation.getStation().getCode() + " nextSt=" + nextStation.getStation().getCode());
        }
        trace("Train::getTrainPosition between " + previousStation.getStation().getCode() + " and " + nextStation.getStation().getCode() + " called at " + atTime);
        
        Point p1 = previousStation.getStation().getPoint();
        float t1 = previousStationTime;
        Point p2 = nextStation.getStation().getPoint();
        float t2 = nextStationTime;
        float t  = sinceDeparted;
        
        trace("Train::getTrainPosition p1=" + p1.getX() + ","+p1.getY()+"  p2="+p2.getX()+","+p2.getY());
        
        float ratio = (t-t1)/(t2-t1);
        float x = p1.getX() + ratio *(p2.getX() - p1.getX());
        float y = p1.getY() + ratio *(p2.getY() - p1.getY());
        return new Point(x,y);

    }
    boolean isFinished()
    {
       return m_finished;
    }
}*/

