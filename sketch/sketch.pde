PImage trainImage;
PImage mapImage;
PImage stationImage;
Table stationTable;
Table configTable;
Table routesTable;
Table departuresTable;
int rowCount;
int configrowCount;
int routesRowCount;
int departuresRowCount;
boolean firstTime = true;
PrintWriter output;
HashMap trainMap;
//ArrayList pointsToPaint;
ArrayList routes;
float lastDraw;
TrainManager trainManager;

void setup() 
{
    lastDraw = now();
    //pointsToPaint = new ArrayList();
    // Create a new file in the sketch directory
    //output = createWriter("data/debug.txt"); 

    //size(1784, 1596);
    size(1189, 1209);
    //pg = createGraphics(892, 798, JAVA2D);
    //background(0, 0, 0);
    
    //mapImage = loadImage("img/map.jpg");
    //mapImage = loadImage("img/map2.jpg");
    //mapImage = loadImage("img/map3.jpg");
    //mapImage = loadImage("img/map4.jpg");
    //mapImage = loadImage("img/map5.jpg");
    mapImage = loadImage("img/map6.jpg");
    //stationImage = loadImage("img/station.png");
    //trainImage = loadImage("img/train.png");

    PFont font =loadFont("TrebuchetMS-48.vlw");
    textFont(font);
    
    //Make a data table from stations.csv which contains the coordinates for all stations, with their lang, lat, x & Y.
    //stationTable = new Table("data/stations.csv");
    //stationTable = new Table("data/stations_2.csv");
    //stationTable = new Table("data/stations_3.csv");
    //stationTable = new Table("data/stations_4.csv");
    stationTable = new Table("data/stations_5.csv");

    //Load config.csv which has the chosen station codes inside, this controls which stations are displayed.
    configTable = new Table("data/config.csv");

    //Load routes.csv
    routesTable = new Table("routes/routes.csv");

    //Load departures.csv
    departuresTable = new Table("routes/departures.csv");



    //row count for stationTable.
    rowCount = stationTable.getRowCount();
    trace("Station table line count = " + rowCount );

    //row count for configTable.
    configrowCount = configTable.getRowCount();
    trace("Config table line count = " + configrowCount );
    trace("--------------------------------------");

    //
    // creating timeobject
    //
    //time = new Time(this);
    trainMap = new HashMap();
    
    //row count for routesTable
    routesRowCount = routesTable.getRowCount();
    routes = new ArrayList();
    //row count for departuresTable
    departuresRowCount = departuresTable.getRowCount();
    routesRowCount = 26;
    for (int i = 0; i < routesRowCount; i+=2)
    {
        String routeName = routesTable.getString(i,0);
        //
        // Departures
        //
        int departureCount = departuresTable.getRowLength(i+1);
        ArrayList departureTimes = new ArrayList();
        for( int k = 1 ; k < departureCount ; ++k )
        {
            departureTimes.add(new Float(departuresTable.getFloat(i+1,k)));    
        }
        
        Route route = new Route(routeName,departureTimes);

        // how many stations in the route
        // remember its one less as the first 
        // is the route name
        //
        int routeLength = routesTable.getRowLength(i);
        trace("--------------------------------------");        
        trace("routeLength = " + routeLength);
        if( routeLength != routesTable.getRowLength(1) )
        {
            //
            // there arent the same number of times as stations
            // NOTE : I have made the last time 0 instead of not
            // having any - check the routes csv there are errors
            //
            //
            // Do some error logging and exit
            //
        }
        for( int j = 1 ; j < routeLength ; ++j )
        {
            //
            //get station code and duration
            //
            String code = routesTable.getString(i,j);
            float duration = routesTable.getFloat(i+1,j);
            String name = stationTable.getString(code, 1);
            float x = stationTable.getFloat(code, 4);  //column 4
            float y = stationTable.getFloat(code, 5);  //column 5
            Station st = new Station(code,name,x,y);
            
            route.addStation(st,duration);
        }
        routes.add(route);
        //
        // So now we should have one route R1 with times T1
        // Noting the last station in a route has duration set to 0
        // i.e. it takes 0 time to get to the next ergo its going 
        // no where
        //
        //
        // Dump the route 
        //
        route.Dump();  
        //
        // Start trains ...
        // 

        //float [] deps = new float[3];
        //deps[0]=15.0;
        //deps[1]=deps[0]+0.5;
        //deps[2]=deps[1]+0.5;
        //Train t1 = new Train(route, this, trainMap, (now()-0.25) );
    }
    trainManager = new TrainManager(routes);
    //Dump();
}

/*void Dump()
{
  trace("Dump");
  Iterator i = trainMap.entrySet().iterator();  // Get an iterator
  while (i.hasNext()) 
  { 
    Map.Entry me = (Map.Entry)i.next();
    TimerEvent te = (TimerEvent)me.getKey();
    Train t = (Train)me.getValue();
    trace( "Dump:" + t.getRoutName() );
  } 
}*/
/*
void timerEvent(TimerEvent sw)
{
    //trace("timerEvent" );
    Train train = (Train)trainMap.get(sw);
    //trace("timerEvent train = " );
    Point p = train.timerEvent();
    pointsToPaint.add(p);
}
*/
void draw() 
{
    if( (now()-lastDraw)*3600 < 2.0 ) return;
    lastDraw = now();
    
    trainManager.updateTrains();
    
    //Dump();
    
    image(mapImage, 0, 0);
    smooth(); 

    fill(0, 168, 255);
    noStroke();
    //
    // Loop through the rows of the stations file and draw points
    //
    for (int row = 0; row < configrowCount; ++row) 
    {
        String code = configTable.getRowName(row);
        //String code = stationTable.getRowName(row);
        //String name = stationTable.getString(row,1);  
        String name = stationTable.getString(code, 1);
        //float x = stationTable.getFloat(row, 4);  //column 4
        //float y = stationTable.getFloat(row, 5);  //column 5
        float x = stationTable.getFloat(code, 4);  //column 4
        float y = stationTable.getFloat(code, 5);  //column 5
        smooth();
        ellipse(x,y, 4, 4);
        //image(stationImage, x-2, y-2);

        if(firstTime==false) continue;

         //trace("Line:" + row);
         //trace("Station Name: " + stationTable.getString(code, 1));
         //trace("Station Code: " + configTable.getRowName(row));
         //trace("X: " + stationTable.getFloat(code, 4));
         //trace("Y: " + stationTable.getFloat(code, 5));
         //trace("--------------------------------------");
         
        //trace(stationTable.getRowName(row));
    }
    //
    // Paint the routes
    //
    for (int i = 0; i < routes.size() ; ++i)
    {
        Route route = (Route)routes.get(i);
        int stationCount = route.getStationCount();
        RouteStation st1 = route.getRoutePoint( 0 );
        for( int j = 1 ; j < stationCount ; ++j )
        {
            RouteStation st2 = route.getRoutePoint( j );
            //
            // draw line between
            //
            Point p1 = st1.getStation().getPoint();
            Point p2 = st2.getStation().getPoint();
            stroke(255, 255, 255, 50);
            //strokeWeight(0.5);
            smooth();
            line(p1.getX(),p1.getY(),p2.getX(),p2.getY());
            stroke(0); 
            //
            // update previous
            //
            st1 = st2;
        }
    }
    //
    // Paint the trains
    //
    fill(204, 102, 0);
    
    ArrayList pointsToPaint = trainManager.getRunningTrainPoints();
    for( int i = 0 ; i < pointsToPaint.size() ; ++i )
    {
        
        Point p = (Point)pointsToPaint.get(i);
        trace("Painting: " + p.getX() +" "+ p.getY());
        smooth();
        fill(255,156,0);    
        ellipse(p.getX(), p.getY(), 5, 5);
        //image(trainImage, p.getX()-4, p.getY()-4);
    }
    
    pointsToPaint.clear();
    firstTime=false;
    //output.flush(); //Writes remaining debug info to the file
    //output.close(); //Finishes the file
}

