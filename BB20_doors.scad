include <BB20.scad>
type="";

PART() BB20Window([1,2], "M");
PART(25) BB20Window([1,2], "S");
PART(50) BB20Window([2,2], "S");



module BB20Window(dim, t)
{  
  di = 2.5;
  do = 5;
  difference()
  {
    union()
    {
      if (t=="M") tx(2.5) BB20Cube([dim.x-0.125, dim.y, 0.25]);
      if (t=="S") tz(-1) {
        tx(2.5) BB20Cube([dim.x-0.125, 0.125, 0.25]);
        tx(2.5) ty(dim.y*20-2.5) BB20Cube([dim.x-0.125, 0.125, 0.25]);
        tx(2.5) BB20Cube([0.18, dim.y, 0.25]);
        tx(dim.x*20-2.5) BB20Cube([0.125, dim.y, 0.25]);
      }
      //BB20Cube([1, L, 1/4]);
      for (y=[0:10:19.9*dim.y]) tx(2.5) tz(2.5) ty(y) rotx(-90) 
       tower([gapd, 1, 4, 5-gapd], [do-1, do, do, do-1]);
    }
    
    if (t=="M") BB20females([1,L,1], [none, none, [1,0]]);
    
    tz(-100) cube(100);
    for (y=[0:10:20*dim.y]) tx(2.5) ty(y) tz(2.5) rotx(-90) 
    {
     tower([0,0.5,4.5,5], [di+1,di, di, di+1]);
     tower([5-gapd,5.5,9.5, 10+gapd], [do, do+1, do+1, do]);

    }
  }

  
  
  //tx(10) tz(10)rotx(-90) cylinder(d=10, h=20*dim.y);
  
}