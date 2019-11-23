include <BB20.scad>

type ="";

PART( 0,0,0) BB20Axle(1);


module BB20Axle(l=1)
{
  tz(10) difference()
  {
    cube_round([D0-2*gapv, D0-2*gapv, l*20-2*gapd], R0, center=true);
    cube([I, I, 20], true);
  }
}