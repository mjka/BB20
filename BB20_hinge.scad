include <BB20.scad>
include <scharnier.scad>

type="";

PART() BB20HingeFlat(1);
PART(0,25) BB20HingeFlat(2);
PART(25) BB20HingeFlat(4);
PART(50) BB20HingeCube(2);



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
  

module BB20HingeCube(L=2)
{
  g3=[gapd,gapd,gapd];
  R=10-gapd;
  difference()
  {
    BB20Cube([1,1,1]);
    BB20females([1,1,1], [[1,0], both, both]);
  }
  tx(40) difference()
  {
    BB20Cube([1,1,1]);
    BB20females([1,1,1], [[0,1], both, both]);
  }
  intersection()
  {
    tx(30) ty(10) union()
    {
      scharnier_a([12,20,20], R, spalt=0.3, freiheit=[-90, 90]);
      scharnier_i([12,20,20], R, spalt=0.3, freiheit=[-90, 90]);
    }
    BB20Cube([3,1,1]);
  }
  BB20supportFemales(pos=[[1,0], both] );
  tx(40) BB20supportFemales(pos=[[0,1], both] );
}