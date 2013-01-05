class Route
{
    Station[] m_stations;
    float[] m_timesToNext;
    int     m_count;
    String  m_routeName; 
    ArrayList m_departureTimes;
    float m_totalDuration;

    Route( String routeName, ArrayList departureTimes )
    {
        m_routeName = routeName;
        m_count=0;
        m_stations= new Station[32];
        m_timesToNext = new float[32];
        m_departureTimes = departureTimes;
        m_totalDuration=0;
        trace("Route::Route has " + m_departureTimes.size() + " departure times");
    }
    void addStation( Station station, float timeToNext )
    {
        m_stations[m_count] = station;
        m_timesToNext[m_count] = timeToNext;
        ++m_count;
        m_totalDuration+=timeToNext;      
        trace("Route::addStation:[" + m_count + "] " + station.getName() + " " + timeToNext + " " +station.getPoint().getX()+","+station.getPoint().getY() );
    }
    int getStationCount()
    {
        return m_count;
    }
    RouteStation getRoutePoint( int index )
    {
        // check index isnt > m_count
        if (index > m_count)
        {
            stop();
        }

        RouteStation rs = new RouteStation( m_stations[index], m_timesToNext[index] ); 
        return rs;
    }
    String getRouteName()
    {
        return m_routeName;
    }
    ArrayList getDepartureTimes()
    {
        return m_departureTimes;
    }
    float getTotalRouteTime()
    {
        return m_totalDuration;
    }
    ArrayList shouldBeRunning(float atTime)
    {
        ArrayList times = new ArrayList();
        for( int i = 0 ; i < m_departureTimes.size() ; ++i )
        {
            float dep = (Float)m_departureTimes.get(i);
            if( dep < atTime && atTime < (dep+(m_totalDuration/60)) )
            {
                trace("dep = " + dep + " atTime = " + atTime + " arr = " + (dep+(m_totalDuration/60)) );
                times.add(dep);    
            }
        } 
        return times;   
    }
    void Dump()
    {
        trace("--------------------------------------");
        trace("Route : " + getRouteName());        
        trace("Dumping " + getStationCount() + " stations");
        for( int i = 0 ; i < getStationCount() ; ++i )
        {
            RouteStation routeStation = getRoutePoint(i);
            trace("Station : " + routeStation.getStation().getName() + " TimeToNext :" + routeStation.getTimeToNext());
        }
        trace("--------------------------------------");
    }
}


