class RouteStation
{
    Station m_station;
    float     m_timeToNext;
    RouteStation( Station station, float timeToNext )
    {
        m_station = station;
        m_timeToNext = timeToNext;
    }
    Station getStation( )
    {
        return m_station;
    }
    float getTimeToNext()
    {
        return m_timeToNext;
    }
}

