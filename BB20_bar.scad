include <mjk.scad>
include <BB20.scad>

gapd= 0.10; // Gap for outer dimensions
gapv = 0.15; // Gap for peg
gapv2 = 0.12; // Gap for peg

type ="";

PART(  0,  0, 0) BB20Ring();
PART(  0,  20, 0) BB20LockSq();
PART(  0,  60, 0) BB20Bar(2);
PART(  20,  0, 0) BB20Bar(3);
PART(  40,  0, 0) BB20Bar(4);
PART(  60,  0, 0) BB20Bar(5);
PART(  80,  0, 0) BB20Bar(6);
PART( 100,  0, 0) BB20Bar(8);
PART( -20,  0, 0) BB20BarSq(2);
PART( -40,  0, 0) BB20BarSq(3);
PART( -60,  0, 0) BB20BarSq(4);



module BB20Bar(l=4)
{
  BB20Ring();
  ty(20*(l-1)) BB20Ring();
  tx(10) ty(l*10) tz(2.5) cubec([7,5+20*(l-2), 5-2*gapd], [1,1,1], true); 
}


module BB20BarSq(l=2)
{
  L = 20*(l-1)*sqrt(2);
  BB20Ring(45);
  ty(L) BB20Ring(45);
  tx(10) ty(10+L/2) tz(2.5) cubec([7,5+L-20, 5-2*gapd], [1,1,1], true); 
}

module BB20Ring(rot=0)
{  
  
  ty(10) tx(10) rotz(rot) 
  difference()
  {
    tower([gapd, 1, 4, 5-gapd], [18, 20-2*gapd, 20-2*gapd, 18]);
    BB20female(gapv);
  }
}

module BB20LockSq()
{    
  g3=[gapd,gapd,gapd];
  ty(10) tx(10) 
  difference()
  {
     tz(2.5) cubec([16, 16, 5]-2*g3, [1,1,1], true);
    
    //tower([gapd, 1, 4, 5-gapd], [18, 20-2*gapd, 20-2*gapd, 18]);
    BB20female(gapv);
  }
}
