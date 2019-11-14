include <mjk.scad>
include <BB20.scad>

type ="";

PART( 0, 0, 0) BB20Brick45([1,1,1]);
PART(25, 0, 0) BB20Brick45([1,1,2]);
PART(50, 0, 0) BB20Brick45([1,1,4]);
PART(75, 0, 0) BB20Brick45([1,1,6]);

PART( 0, 25, 0) BB20Brick45([2,2,1]);
PART(50, 25, 0) BB20Brick45([2,2,2]);
PART(100,25, 0) BB20Brick45([2,2,4]);

PART( 0, 75, 0) BB20Brick45([4,4,1]);

PART(0, -25, 0) BB20Brick45([1,1,1], peg=1);

module BB20Brick45(dim=[1,1,4], peg=0)
{  
  g3=[gapd,gapd,gapd];
  difference()
  {
    intersection()
    {
      translate(g3) cubec(20*dim-2*g3, 1.0*[1,1,1]);
      dia = 1.41459*20;
      translate([-1,1, 0]) rotz(-45) translate(g3) cubec([dia*dim.x, dia*dim.y, 20*dim.z]-2*g3, 1.0*[1,1,1]);
    }
    if (peg < 2) for (z=[1:dim.z]) for (y=[1:dim.y]) translate([dim.x*20-10, 20*y-10, 20*z-10]) 
    {
      mx() roty() my() tz(-10) BB20female(H=5.5); 
    }
    if (peg < 1) for (z=[1:dim.z]) for (x=[1:dim.x]) 
      translate([x*20-10, 0, 20*z-10]) rotx(-90) BB20female(H=5.5); 
    //translate([10, dim.y*20, 10]) rotx() BB20female(gapv); 
    //if(back) translate([10, 0, 10]) rotx(-90) cylinder(d=12.5, h=dim.y*20);
    //translate([10, 0, 10]) rotx(-90) tz(10*dim.y) 
    //  cube_round([D0+2*gapv,D0+2*gapv,dim.y*20-4], R0+gapv, center=true);
  }
  
  if (peg > 0) union()
  {
    translate([10, gapd, 10]) rotx(90) rotz(45) BB20male();
    translate([10, gapd, 10]) SupportMale();
  }
  
  if (peg < 2) for (z=[1:dim.z]) for (y=[1:dim.y]) translate([dim.x*20-10, 20*y-10, 20*z-10]) 
    SupportFem();
  if (peg < 1) for (z=[1:dim.z]) for (x=[1:dim.x]) 
      translate([x*20-10, -5, 20*z-10]) rotz() SupportFem();
}

