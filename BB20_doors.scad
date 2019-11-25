include <BB20.scad>
type="";

PART() BB20Window([1,2], "M");
PART(25) BB20Window([1,2], "S");
PART(50) BB20Window([2,2], "S");
PART(0,50) BB20Door([2,2]);
PART(50 ,50) BB20Door([2,3]);
PART(100 ,50) BB20Door([2,4]);


module BB20Door(dim)
{
  g3=[gapd, gapd, gapd];
  difference()
  {
    intersection()
    {
      union()
      {
        BB20Cube([dim.x, dim.y, 0.25]);
        BB20Cube([0.75, 0.25, 0.5]);
        ty(dim.y*20-5) BB20Cube([0.75, 0.25, 0.5]);
      }  
      translate(g3) tz(-5) rotx() mz() cube_round([dim.x*20+20, 30, dim.y*20]-2*g3, 10);
    }
    tx(dim.x*20-0) ty(dim.y*10) tower([0,1,4,5], [12,10,10,12]);
    
    *tx(dim.x*20-7) ty(dim.y*10) difference()
    {
      cubec([12, 5, 1], 0.4*[1,1,1], true);
      cubec([10, 2, 2], 0.4*[1,1,1], true);
    }
  }
  tx(10) tz(5) rotx(-90) tower([-4.5, -3.5, 4], [8,10-2*gapd,10-2*gapd]); 
  tx(10) tz(5) rotx(-90) tower([dim.y*20-4 , dim.y*20+3.5, dim.y*20+4.5], [10-2*gapd,10-2*gapd,8]); 
}

module BB20Window(dim, t)
{  
  di = 2.5;
  do = 5;
  difference()
  {
    union()
    {
      if (t=="M") tx(2.5) BB20Cube([dim.x-0.125, dim.y, 0.25]);
      if (t=="S") tz(0) {
        tx(2.5) BB20Cube([dim.x-0.125, 0.25, 0.25]);
        tx(2.5) BB20Cube([0.25, dim.y, 0.25]);
        tx(2.5) ty(dim.y*20-5) BB20Cube([dim.x-0.125, 0.25, 0.25]);
        tx(dim.x*20-5) BB20Cube([0.25, dim.y, 0.25]);
      }
      //BB20Cube([1, L, 1/4]);
      for (y=[0:10:19.9*dim.y]) tx(2.5) tz(2.5) ty(y) rotx(-90) 
       tower([gapd, 1, 4, 5-gapd], [do-1, do, do, do-1]);
    }
    
    if (t=="M") BB20females([1,L,1], [none, none, [1,0]]);
    
    tz(-100) cube(100);
    for (y=[0:10:19.9*dim.y]) tx(2.5) ty(y) tz(2.5) rotx(-90) 
    {
     tower([0,0.5,4.5,5], [di+1,di, di, di+1]);
     tz(7.5) ty(-2.5) cube([5.5,5.5,5.5], true);
     tower([5-gapd,5.5,9.5, 10+gapd], [do, do+1, do+1, do]);

    }
    
    if (t=="S") tz(3) tx(2.5+3) ty(3) cube([dim.x*20-2.5-6, dim.y*20-6, 10]);
    
  }

  
  
  //tx(10) tz(10)rotx(-90) cylinder(d=10, h=20*dim.y);
  
}