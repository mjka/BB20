include <mjk.scad>
include <BB20.scad>

gapd= 0.10; // Gap for outer dimensions
gapv = 0.15; // Gap for peg
gapv2 = 0.12; // Gap for peg

type ="";
///# Connectors

PART(  0,  0, 0) BB20ConSide();
PART( 20,  0, 0) BB20ConNoHead();
PART( 40,  0, 0) BB20ConNoHead(15);
PART( 60,  0, 0) BB20ConNoHead(20);
PART( 80,  0, 0) BB20ConNoHead(25);

PART(  0, 20, 0) BB20Con(10);
PART( 20, 20, 0) BB20Con(15);
PART( 20, 20, 0) BB20Con(20);
PART( 40, 20, 0) BB20Con(30);
PART( 40, 20, 0) BB20Con(35);
PART( 60, 20, 0) BB20Con(50);

PART(  0, 40, 0) BB20Con(15,2);
PART( 20, 40, 0) BB20Con(30,2);
PART( 40, 40, 0) BB20Con(35,2);

  
  
module BB20ConSide(gapv=gapv+gapv2) 
{
  tz(-gapv) intersection() 
  {
    color("green") tz(D0/2) cube([D0, 10-2*gapv, D0], true);
    tz(D0/2) rotx() cmz() BB20male(-gapv);
  }  
  if (support)
    difference() {tz(0.1) cube([15,15,0.2], true); cube([8.0,9.9,1], true); }
}


module BB20ConOld(gapv=gapv)
{ 
  tz(5) intersection() {
    color("blue") cylinder(r=10, h=10, center=true);
    cmz() BB20male(-gapv);
  }
  if (support) 
    difference() { cylinder(h=0.2, d=15);cylinder(h=2, d=11.1, center=true);}
}

module BB20ConNoHead(l=10, support=true)
{
  BB20Con(head=false, h=l, rings=l/5, support=support);
}

module BB20Con(h=10, rings=1, gapv=gapv, head=true, support=false)
{   
  difference()
  {
    union()
    {
      for (n=[1:rings])
      {         
        tz(2.5+h-5*n) mirror([0,0,n%2]) tz(-2.5) BB20male(-gapv);
      }
      
      if (head) rotz(45) hull_tower()
      {
        rr = 4;
        d = (19 - 2*rr) / sqrt(2) + 2*rr;  
        tz(0) cube_round([d-2,d-2,e], rr-1, center=true);
        tz(1) cube_round([d,d,e], rr, center=true);
        tz(4) cube_round([d,d,e], rr, center=true);
        tz(5+e) cube_round([d-2,d-2,e], rr-1, center=true);
      }
      cylinder(d=D0-2*gapv, h=h);
    }
    hull_tower() 
    {
      tz(0) cube([I+1,I+1,e], true); 
      tz(0.5) cube([I,I,e], true);
      tz(2) cube([I,I,e], true);
      tz(3) cylinder(h=e, d=sqrt(2)*I, true);
      tz(h-3) cylinder(h=e, d=sqrt(2)*I, true);
      tz(h-2) cube([I,I,e], true); 
      tz(h-0.5) cube([I,I,e], true); 
      tz(h)cube([I+1,I+1,e], true); 
    }
  }
  if (support) 
    difference() { cylinder(h=0.2, d=15);cylinder(h=2, d=10.5, center=true);}
}
