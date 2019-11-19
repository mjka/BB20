include <mjk.scad>
include <BB20.scad>

gapd= 0.10; // Gap for outer dimensions
gapv = 0.15; // Gap for peg
gapv2 = 0.12; // Gap for peg
e = 0.05;
type ="";

PART(  0,  0, 0) BB20Brace(3);
PART( 30,  0, 0) BB20Brace(4);
PART( 60,  0, 0) BB20Brace(5);
PART( 90,  0, 0) BB20Brace(6);
//
module BB20Brace(l=4)
{
  difference()
  {
    union()
    {
      difference()
      {
        hull_tower()
        {
          BB20Round();
          tx(20) ty(20) BB20Round();
          tx(20) ty(20*(l-2)) BB20Round();
          ty(20*(l-1)) BB20Round();      
        }
        tx(10) ty(10*l) hull_tower()
        {
          cube_round([2+20, 6+20*(l-2), e], 4, true);
          tz(1) cube_round([20, 4+20*(l-2), e], 4, true);
          tz(4) cube_round([20, 4+20*(l-2), e], 4, true);
          tz(5) cube_round([2+20, 6+20*(l-2), e], 4, true);
        }
      }
          BB20Round();
          ty(20*(l-1)) BB20Round();      
    }
    
    tx(10) ty(10) BB20female(gapv);
    tx(10) ty(20*l-10) BB20female(gapv);
    for(x=[2:l-1]) tx(30) ty(20*x-10) BB20female(gapv);
  }
}


module BB20Round(d=20)
{    
  ty(10) tx(10) tower([gapd, 1, 4, 5-gapd], [d-2, d-2*gapd, d-2*gapd, d-2]);
}
