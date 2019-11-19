include <mjk.scad>
include <BB20.scad>

gapd= 0.10; // Gap for outer dimensions
gapv = 0.15; // Gap for peg
gapv2 = 0.12; // Gap for peg

type ="";

PART(  0,  0, 0) BB20Beam([1,1,1]);
PART( 25,  0, 0) BB20Beam1m([1,1,1]);
PART( 50,  0, 0) BB20Beam2m([1,1,1]);

PART(-50,  0, 0) BB20Beam([2,4,1]);
PART(0, -40, 0) BB20Lenker();

*union() {
PART(-150,  0, 0) BB20Beam([2,8,1]);
PART(-100,  0, 0) BB20Beam([2,10,1]);
PART(  0, 35, 0) BB20Beam([1,2,1]);
PART(  0, 90, 0) BB20Beam([1,3,1]);
PART(  0,160, 0) BB20Beam([1,4,1]);
PART( 25, 35, 0) BB20Beam1m([1,2,1]);
PART( 25, 90, 0) BB20Beam1m([1,3,1]);
PART( 25,160, 0) BB20Beam1m([1,4,1]);
PART( 50, 35, 0) BB20Beam2m([1,2,1]);
PART( 50, 90, 0) BB20Beam2m([1,3,1]);
PART( 50,170, 0) BB20Beam2m([1,4,1]);
PART( 75,  0, 0) BB20Beam([1,5,1]);
PART(100,  0, 0) BB20Beam([1,6,1]);
PART(125,  0, 0) BB20Beam([1,8,1]);
}
//    tz(-gapd) tx(-25) ty(40) BB20BeamL([2,2,1], gapd=gapd, gapv=gapv, bottom=false);
//    tz(-gapd) tx(-75) ty(40) BB20BeamU([2,2,1], gapd=gapd, gapv=gapv, bottom=false);
//    tz(-gapd) tx(-25) BB20Beam1m([1,1,1], gapd=gapd, gapv=gapv);
//    tz(-gapd) tx(-50) BB20Beam2m([1,1,1], gapd=gapd, gapv=gapv);
//    tz(-gapd) tx(-75) BB20Beam2m([1,2,1], gapd=gapd, gapv=gapv);
//    
    
    
    

module BB20Beam1m(dim=[1,1,1], gapd=gapd, gapv=gapv)
{
  difference()
  {
    BB20Beam(dim, gapd=gapd, front=false, back=true);
    //tx(10) tz(10) rotx(-90) cylinder(d=sqrt(2)*I, h=dim.y*20);
  }
  
  {
    translate([10, gapd, 10]) rotx(90) rotz(45) BB20male(-gapv);
    translate([7, -3.6, gapd]) cube([6, 0.8, 3.3]);
    translate([7, -5.5, gapd]) cube([6, 5, 0.4]);
  }
}

module BB20Beam2m(dim=[1,1,1], gapd=gapd, gapv=gapv)
{
  difference()
  {
    BB20Beam(dim, gapd=gapd, front=false, back=false);
    tx(10) tz(10) rotx(-90) cylinder(d=sqrt(2)*I, h=dim.y*20);
  }
  ty(dim.y*10) cmy() ty(dim.y*10) 
  {
    translate([10, -gapd, 10]) 
    {
      rotx(-90) rotz(45) BB20male(-gapv);
      ty(5) SupportMale();
    }
    //translate([7, 2.0, gapd]) cube([6, 0.8, 3.3]);
    //translate([7, 0, gapd]) cube([6, 5, 0.4]);
  }
}

module BB20Lenker(dim=[2,1,1], gapd=gapd, gapv=gapv)
{
  difference()
  {
    BB20Beam(dim, gapd=gapd, front=false, back=false);
    //tx(10) tz(10) rotx(-90) cylinder(d=sqrt(2)*I, h=dim.y*20);
  }
  for (x=[1:dim.x]) ty(dim.y*10) cmy() ty(dim.y*10) 
  {
    translate([20*x-10, 5-gapd, 10]) 
    {
      rotx() cylinder(d=D0-2*gapv, h=6 );

      rotx(-90) rotz(45) BB20male(-gapv);
      ty(5) SupportMale();
    }
    //translate([7, 2.0, gapd]) cube([6, 0.8, 3.3]);
    //translate([7, 0, gapd]) cube([6, 5, 0.4]);
  }
}

module BB20Beam(dim=[1,2,1], horz=true, vert=true, front=true, back=true, gapd=gapd, gapv=gapv)
{
  g3=[gapd,gapd,gapd];
  difference()
  {
    translate(g3) cubec(20*dim-2*g3, 1.0*[1,1,1]);
    for (x=[1:dim.x]) for (y=[1:dim.y]) translate([20*x-10, 20*y-10, 10]) 
    {
      if(vert) tz(-10) BB20female(gapv-gapv2*1.2);
      if(vert) mz() tz(-10) BB20female(gapv-gapv2*0.8);
    }
    if (horz) for (y=[1:dim.y]) 
    {
     translate([10, 20*y-10, 10]) roty() my() tz(-10) BB20female(gapv); 
     translate([20*dim.x-10, 20*y-10, 10]) mx() roty() my() tz(-10) BB20female(gapv); 
    }
    if(front) for (x=[1,dim.x]) translate([20*x-10, 0, 10]) rotx(-90) BB20female(gapv); 
    if(back) for (x=[1,dim.x])  translate([20*x-10, dim.y*20, 10]) rotx() BB20female(gapv); 
    //if(back) translate([10, 0, 10]) rotx(-90) cylinder(d=12.5, h=dim.y*20);
    for (x=[1:dim.x]) translate([20*x-10, 0, 10]) rotx(-90) tz(10*dim.y) 
      cube_round([D0+2*gapv,D0+2*gapv,dim.y*20-4], R0+gapv, center=true);
    for (y=[1:dim.y]) translate([0, 20*y-10, 10]) roty(90) tz(10*dim.x) 
      cube_round([D0+2*gapv,D0+2*gapv,dim.x*20-4], R0+gapv, center=true);
  }
  if (horz) for (y=[1:dim.y]) translate([10, 20*y-10, 10]) 
  {
     tx(dim.x*20-20)SupportFem();
      mx() SupportFem();
  }
  //tx(-7.5) { difference() { cube([3, 6, 10], true); cube([2, 5, 12], true); }  }
  if (front) for (x=[1,dim.x]) translate([20*x-10, -5, 10]) rotz() SupportFem();
  if (back)  for (x=[1,dim.x]) translate([20*x-10, 20*dim.y-10, 10]) rotz() SupportFem();
}


