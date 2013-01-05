class Station
{
    float   m_x;
    float   m_y;
    String  m_code;
    String  m_name;

    Station( String code, String name, float x, float y )
    {
        m_x = x;    
        m_y = y;
        m_code = code;
        m_name = name;
        trace("Station::Station:[" + m_code + "] " + m_name + " " +m_x+","+m_y );
    }
    String getCode()
    {
        return m_code;
    }
    String getName()
    {
        return m_name;
    }
    float getX()
    {
        return m_x;
    }
    float getY()
    {
        return m_y;
    }
    Point getPoint()
    {
        return new Point(m_x, m_y) ;
    }
}

