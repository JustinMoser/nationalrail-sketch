float now()
{
    float h = hour();
    float m = minute();
    float s = second();
    return h + m/60 + s/3600;
}


void trace( String message )
{
    /*
    String m;
    m = ""+nf(year(),4)+"-"+nf(month(),2)+"-"+nf(day(),2)+"-"+nf(hour(),2)+":"+nf(minute(),2)+":"+nf(second(),2)+"."+nf(millis(),3)+" : ";
    m+=message;
    //println(m);
    output.println(m);
    */
}
