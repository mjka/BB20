include <BB20.scad>
include <scharnier.scad>

type="";

PART() BB20HingeFlat(2);
PART() BB20HingeCube(2);





module BB20HingeFlat(L=2)
{
  di = 2;
  do = 6;
  difference()
  {
    union()
    {
      BB20Cube([1, L, 1/4]);
      for (y=[0:10:19.9*L]) tx(20) ty(y) tz(5) rotx(-90) 
       tower([gapd, 1, 4, 5-gapd], [do-1, do, do, do-1]);
    }
    
    BB20females([1,L,1], [none, none, [1,0]]);
    for (y=[0:10:20*L]) tx(20) ty(y) tz(5) rotx(-90) 
    {
     tower([0,0.5,4.5,5], [di+1,di, di, di+1]);
     tower([5-gapd,5.5,9.5, 10+gapd], [do, do+1, do+1, do]);

    }
  }
}
  