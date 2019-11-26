include <BB20.scad>

type="";

union() {
//PART(-100) BB20LogCorner(4);
PART(-75) BB20LogCorner(3);
PART(-50) BB20LogCorner(2);
PART(-25) BB20LogCorner(1);
}
*  union() {
PART() BB20LogDouble(1);
PART(0,25) BB20LogDouble(2);
PART(0,75) BB20LogDouble(3);
PART(25,0) BB20LogDouble(4);
PART(50,0) BB20LogDouble(8);
PART(75,0) BB20LogSingle(8);
PART(100,0) BB20LogSingle(4);
PART(125,75) BB20LogSingle(3);
PART(125,25) BB20LogSingle(2);
PART(125,0) BB20LogSingle(1);
}
*union(){
PART(0) BB20LogHalf(1);
PART(0,25) BB20LogHalf(2);
PART(0,75) BB20LogHalf(3);
PART(25) BB20LogHalf(4);
PART(50) BB20LogHalf(8);

PART(75,0) BB20LogHalfCorner(1);
PART(75,25) BB20LogHalfCorner(2);
PART(75,75) BB20LogHalfCorner(3);
PART(100) BB20LogHalfCorner(4);
PART(125) BB20LogHalfCorner(8);
}

module LogCut()
{ 
  mx() rotz() intersection()
  {
    tz(5-gapd) cube([20, 20, 10+2*gapd]);
    intersection_for(x=[-5,5]) tx(10+x) tz(10) rotx(-90) cylinder(h=20, d=30+gapd*2);
  }
}

module Log(L)
{
  intersection()
  {
    BB20Cube([1, L, 1]);
    intersection_for(x=[-5,5]) tx(10+x) tz(10) rotx(-90) tower([0,1,L*20-1, L*20], [28,30,30,28]);
  }
}
  
module BB20LogHalfCorner(L)
{
  difference()
  {
    tz(-10) Log(L); 
    ty(L==1?0:20) LogCut();
    tz(gapd-20) cube([20, 20*L, 20]);
    for(y=[10:20:L*20]) ctz([5,0]) ty(y) tx(10) BB20female();
  }
}
module BB20LogHalf(L)
{
  difference()
  {
    tz(-10) Log(L); 
    tz(gapd-20) cube([20, 20*L, 20]);
    for(y=[10:20:L*20]) ctz([5,0]) ty(y) tx(10) BB20female();
  }
}
module BB20LogSingle(L)
{
  difference()
  {
    intersection()
    {
      BB20Cube([1, L, 1]);
      tx(10+5) tz(10) rotx(-90) tower([0,1,L*20-1, L*20], [28,30,30,28]);
    }
    BB20females([1,L,1], [none, both, none], H=11*L);
    BB20females([1,L,1], [[0,1], none, both]);
  }
}

module BB20LogDouble(L)
{
  difference()
  {
    Log(L);
    BB20females([1,L,1], [none, both, both], H=11*L);
  }
}

module BB20LogCorner(L)
{  
  difference()
  {
    Log(L);
    ctz([+10,-10]) ty(20) LogCut();
    
    //tz(-5) ty(30) tx(10) rotz() scale(1.03) translate([-10, -10, -10]) Log(1);
    //tz(25) ty(30) tx(10) rotz() scale(1.03) translate([-10, -10, -10]) Log(1);
    BB20females([1,1,1], [none, none, both]); 
    if (L!=2) ty(L*20-20) BB20females([1,1,1], [none, [0,1], none]);
    if (L>2) ty(40) BB20females([1,L-2,1], [none, none, both]);
    if (L>1) ctz([5,10]) ty(30) tx(10) BB20female();
  }
  if (L>1)
  {
    tz(gapd) ty(20+4) tx(1) SupportCube([18,12, 4.8], false );
    tz(gapd) ty(20+4) tx(4) SupportCube([12,12, 4.8], false );
  }
  if (L!=2)
  {
    BB20supportFemales([1,L,1], [none, [0,1], none]);
  }
  if (L==2) 
    tz(gapd) ty(20+15.5) tx(1) SupportCube([16,4.5,2.2], false );
}



module ctx(a) { for (x=a) tx(x) children(); }
module cty(a) { for (x=a) ty(x) children(); }
module ctz(a) { for (x=a) tz(x) children(); }