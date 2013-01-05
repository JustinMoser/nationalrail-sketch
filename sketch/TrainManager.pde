class TrainManager
{
    ArrayList m_routes;
    //
    // map< route, ArrayList<Train> >;
    //
    HashMap m_runningTrainsOnRoutes;

    TrainManager( ArrayList routes )
    {
        m_routes = routes;
        m_runningTrainsOnRoutes = new HashMap();
    }

    void updateTrains( )
    {
        trace(">>> TrainManager::updateTrains"); 
        //
        // remove old
        //
        Iterator i = m_runningTrainsOnRoutes.entrySet().iterator();  // Get an iterator
        while (i.hasNext()) 
        {
            Map.Entry me = (Map.Entry)i.next();
            ArrayList trains = (ArrayList)me.getValue();
            trace("TrainManager::updateTrains[removeold] trains count = "+trains.size()); 
            //for( int j = 0 ; j < trains.size() ; ++j )
            for( int j = trains.size()-1 ; j >= 0 ; --j )
            {
                TrainEx train = (TrainEx)trains.get(j);;
                if( train.isFinished() )
                {
                    trace("TrainManager::updateTrains[removeold] removing train = "+train.getRoutName()+":"+train.getStartTime()); 
                    trains.remove(j);    
                }        
            }        
        }        
        //
        // start new :
        //
        for( int k = 0 ; k < m_routes.size() ; ++k )
        {
            Route route = (Route)m_routes.get(k);
            ArrayList shouldBeRunningTimes = route.shouldBeRunning(now());
            //
            // Are any of these running already
            //
            if( m_runningTrainsOnRoutes.containsKey(route) )
            {
                ArrayList runningTrains = (ArrayList)m_runningTrainsOnRoutes.get(route);
             
                for( int j = 0 ; j < runningTrains.size() ; ++j )
                {
                    TrainEx train = (TrainEx)runningTrains.get(j);
                    if( shouldBeRunningTimes.contains(train.getStartTime()))
                    {
                        //
                        // remove it as its already running
                        //
                        trace("Removing already running trains from to start list");
                        for( int m = 0 ; m < shouldBeRunningTimes.size() ; ++m )
                        {
                            if( train.getStartTime() == (Float)shouldBeRunningTimes.get(m) )
                            {
                                shouldBeRunningTimes.remove(m);    
                            }
                        }
                    }    
                }
                trace("Adding " + shouldBeRunningTimes.size()+ " non running trains from to start list");
                ArrayList trains = (ArrayList)m_runningTrainsOnRoutes.get(route);
                for( int n = 0 ; n < shouldBeRunningTimes.size() ; ++n )
                {
                    TrainEx train = new TrainEx( route, (Float)shouldBeRunningTimes.get(n) );
                    if( !train.isFinished() )
                    {
                        trains.add( train );
                    }   
                }
            }
            else
            {
                ArrayList trains = (ArrayList)m_runningTrainsOnRoutes.get(route);
                if( trains == null )
                {
                    m_runningTrainsOnRoutes.put(route,new ArrayList());   
                    trains = (ArrayList)m_runningTrainsOnRoutes.get(route);
                }
                for( int n = 0 ; n < shouldBeRunningTimes.size() ; ++n )
                {
                    TrainEx train = new TrainEx( route, (Float)shouldBeRunningTimes.get(n) );
                    if( !train.isFinished() )
                    {
                        trains.add( train );
                    }   
                }
                m_runningTrainsOnRoutes.put(route,trains);                    
            }
        }
        trace("<<< TrainManager::updateTrains"); 
    }
    ArrayList getRunningTrainPoints()
    {
        ArrayList points = new ArrayList();
        //
        // build list of running trains
        //
        Iterator i = m_runningTrainsOnRoutes.entrySet().iterator();  // Get an iterator
        while (i.hasNext()) 
        {
            Map.Entry me = (Map.Entry)i.next();
            ArrayList trains = (ArrayList)me.getValue();
            for( int j = 0 ; j < trains.size() ; ++j )
            {
                TrainEx train = (TrainEx)trains.get(j);;
                if( !train.isFinished() )
                {
                     Point p = train.getTrainPosition(now());
                     points.add(new Point(p.getX(),p.getY()));
                }        
            }        
        }        
        return points;
    }
}
