use <mjk.scad>

$fs=0.5; $fn=36; e=0.01;
gapd= 0.10; // Gap for outer dimensions
gapv = 0.15; // Gap for peg
gapv2 = 0.12; // Gap for peg
ddd = 0.50; // [0..1] 0 --> easy to rotate, 1 --> hard to rotate
D0 = 10; // Size of peg
R0 = 2; // Corner radius of peg
I = 5; // Inner hole inside the peg
support = true;

type="GUI";
L=10;

if (type=="GUI")
{
  union(){
    //tz(-gapd) BB20Beam([1,2,0.25], gapd=gapd, back=true);
    tz(-gapd) BB20Plate([1,2], gapd=gapd, gapv=gapv);
    tz(-gapd) tx(22) BB20PlateR([1,2], gapd=gapd, gapv=gapv);
    //tz(-gapd) tx(22) BB20Beam([1,2,0.25], gapd=gapd, back=false, horz=false, front=false);
    tz(-gapd) tx(-25) ty(40) BB20BeamL([2,2,1], gapd=gapd, gapv=gapv, bottom=false);
    tz(-gapd) tx(-75) ty(40) BB20BeamU([2,2,1], gapd=gapd, gapv=gapv, bottom=false);
    tz(-gapd) tx(-25) BB20Beam1m([1,1,1], gapd=gapd, gapv=gapv);
    tz(-gapd) tx(-50) BB20Beam2m([1,1,1], gapd=gapd, gapv=gapv);
    tz(-gapd) tx(-75) BB20Beam2m([1,2,1], gapd=gapd, gapv=gapv);
    
    tz(-gapd) tx(100) BB20345();
    
  tx(50)ty(10) BB20Con(gapv);
  tx(50)ty(30) BB20ConSide(gapv+gapv2);
  //tx(50)ty(50) BB20ConHead(gapv);
  }
} 
else if (type == "Beam")
  BB20Beam(dim, gapd=gapd, gapv=gapv);
else if (type == "BeamU")
  BB20BeamU(dim, gapd=gapd, gapv=gapv);
else if (type == "BeamL")
  BB20BeamL(dim, gapd=gapd, gapv=gapv);
else if (type == "BeamM")
  BB20Beam1m(dim, gapd=gapd, gapv=gapv);
else if (type == "Beam2M")
  BB20Beam2m(dim, gapd=gapd, gapv=gapv);
else if (type == "Plate")
  BB20Plate(dim, gapd=gapd, gapv=gapv);
else if (type == "PlateR")
  BB20PlateR(dim, gapd=gapd, gapv=gapv);
else if (type == "Brick45")
  BB20Brick45(dim);
else if (type == "345")
  BB20345();



module BB20345()
{
  g3=[gapd,gapd,gapd];
  difference()
  {
    translate(g3) intersection()
    {
      cubec([20*3, 20*4, 20]-2*g3, 1.0*[1,1,1]);
      rotz(-asin(3/5)) cubec([20*4, 20*5, 20]-2*g3, 1.0*[1,1,1]);
      
      union() {
        cubec([20*3, 5, 20]-2*g3, 1.0*[1,1,1]);
        tx(55) cubec([5, 20*4, 20]-2*g3, 1.0*[1,1,1]);
        rotz(-asin(3/5)) cubec([5, 20*5, 20]-2*g3, 1.0*[1,1,1]);
      }
    }
    for (y=[1:4]) translate([60, 20*y-10, 10]) roty(-90) BB20female(gapv, H=6);
    for (x=[1:3]) translate([20*x-10, 0, 10]) rotx(-90) BB20female(gapv, H=6);
    for (y=[1:5]) rotz(-asin(3/5))  translate([0, 20*y-10, 10]) roty() BB20female(gapv, H=6);
  }
  translate([1,1,gapd]) intersection(){
    cube([20*3, 20*4, 1]-[2,2,0]);
    rotz(-asin(3/5)) cube([20*4, 20*5, 1]-[2,2,0]);
  }
  // Support 
  for (y=[1:4]) translate([50, 20*y-10, 10]) SupportFem();
  for (x=[1:3]) translate([20*x-10, -5, 10]) rotz() SupportFem();
  for (y=[1:5]) rotz(-asin(3/5))  translate([-5, 20*y-10, 10]) SupportFem();
    
}

module BB20Cube(dim=[1,1,1])
{  
  g3=[gapd,gapd,gapd];
  translate(g3) cubec(20*dim-2*g3, 1.0*[1,1,1]);
}

both=[1,1]; none=[0,0];

module BB20females(dim=[1,1,1], pos=[both,both,both], H=10.01, gapd=gapd, gapv=gapv)
{
    for (x=[1:dim.x]) for (y=[1:dim.y]) translate([20*x-10, 20*y-10,0 ]) 
    {
      if(pos.z[0]) BB20female(gapv-gapv2*1.2, H);
      if(pos.z[1]) tz(dim.z*20) mz() BB20female(gapv-gapv2*0.8, H);
    }
    for (y=[1:dim.y]) for (z=[1:dim.z]) translate([0, 20*y-10, 20*z-10])
    {
     if (pos.x[0]) BB20femaleV(gapv, H); 
     if (pos.x[1]) tx(20*dim.x) mx() BB20femaleV(gapv, H); 
    }
    for (x=[1,dim.x]) for (z=[1:dim.z]) translate([20*x-10, 0, 20*z-10]) 
    {
      if (pos.y[0]) rotz() BB20femaleV(gapv, H); 
      if (pos.y[1]) ty(dim.y*20) rotz(-90) BB20femaleV(gapv, H); 
    }
}

module BB20femaleV(gapv, H=10.01)
{
  tx(10) roty(-90) tz(10) mz() BB20female(gapv, H);
}

module BB20supportFemale(ignore)
{
  if (support)
  {
    tz(-0.1) tx(2.5) difference() { cube([3,6,9.8], true);  cube([2,5,12], true); }
  }
}


module BB20supportFemales(dim=[1,1,1], pos=[both,both,both], gapd=gapd, gapv=gapv)
{
    for (y=[1:dim.y]) for (z=[1:dim.z]) translate([0, 20*y-10, 20*z-10])
    {
     if (pos.x[0]) BB20supportFemale(gapv); 
     if (pos.x[1]) tx(20*dim.x) mx() BB20supportFemale(gapv); 
    }
    for (x=[1,dim.x]) for (z=[1:dim.z]) translate([20*x-10, 0, 20*z-10]) 
    {
      if (pos.y[0]) rotz() BB20supportFemale(gapv); 
      if (pos.y[1]) ty(dim.y*20) rotz(-90) BB20supportFemale(gapv); 
    }
}

module SupportFem()
{
  if (support)
  {
    tx(7.5)  difference() { cube([3, 6, 10], true);  cube([2, 5, 12], true); }
  }
}


module BB20BeamL(dim=[1,2,1], gapd=0.1, gapv=0.05, bottom=true)
{
  g3=[gapd,gapd,gapd];
  difference()
  {
    union()
    {
      translate(g3) cubec([20*dim.x, 20*dim.y, 5]-2*g3, 1.0*[1,1,1]);
      translate(g3) cubec([5, 20*dim.y, 20*dim.z]-2*g3, 1.0*[1,1,1]);
    }
    for (y=[1:dim.y]) translate([10, 20*y-10, 10]) 
    {
      if (bottom) for (x=[1:dim.x]) tx(20*(x-1)) tz(-10) BB20female(gapv);
      roty() my() tz(-10) BB20female(gapv); 
    }    
  }  
  for (y=[1:dim.y]) translate([10, 20*y-10, 10]) mx() SupportFem();

}

module BB20BeamU(dim=[1,2,1], gapd=0.1, gapv=0.05, bottom=true)
{
  g3=[gapd,gapd,gapd];

  difference()
  {
    union()
    {
      translate(g3) cubec([20*dim.x, 20*dim.y, 5]-2*g3, 1.0*[1,1,1]);
      translate(g3) cubec([5, 20*dim.y, 20*dim.z]-2*g3, 1.0*[1,1,1]);
      translate(g3) tx(dim.x*20-5) cubec([5, 20*dim.y, 20*dim.z]-2*g3, 1.0*[1,1,1]);
    }
    for (y=[1:dim.y]) translate([10, 20*y-10, 10]) 
    {
      if (bottom) for (x=[1:dim.x]) tx(20*(x-1)) tz(-10) BB20female(gapv);
      roty()  tz(-10) BB20female(gapv); 
      roty()  tz(20*dim.x-10) mz()BB20female(gapv); 
    }    
  }  
  for (y=[1:dim.y]) translate([-5, 20*y-10, 10]) SupportFem();
  for (y=[1:dim.y]) translate([dim.x*20-10, 20*y-10, 10]) SupportFem();

}




module BB20ConHeadOld(gapv=gapv, extra=15)
{ 
  difference()
  {
    union()
    {
      tz(10+extra) cmz() BB20male(-gapv);
      rr = 4;
      d = (19 - 2*rr) / sqrt(2) + 2*rr;  
      rotz(45) hull_tower()
      {
        tz(0) cube_round([d-2,d-2,e], rr-1, center=true);
        tz(1) cube_round([d,d,e], rr, center=true);
        tz(4) cube_round([d,d,e], rr, center=true);
        tz(5+e) cube_round([d-2,d-2,e], rr-1, center=true);
      }
      cylinder(d=D0-2*gapv, h=extra+6);
    }
    tz(-1) cylinder(h=10+extra, d=sqrt(2)*I);
  }
}

module SupportMale()
{  
    translate([-3, -3.0, gapd-10]) cube([6, 0.8, 3.8]);
    translate([-3, -5, gapd-10]) cube([6, 5, 0.4]);
}

*ty(-10) tx(15) BB20male();

module BB20male(o=-gapv)
{  
  H=[0, 0.6, 2.2, 2.8, 4.4, 5];
  d=D0+2*o; // through hole
  rr = R0+o;
  intersection()
  {
    color("pink") cylinder(h=H[5], d2=10, d1=20); // bounding conus
    difference()
    {
      hull_tower()
      {
        tz(H[0]) cylinder(h=e, d=d, center=true);
        tz(H[1]) cylinder(h=e, d=d, center=true);
        tz(H[2]) cube_round([d,d,e], rr, center=true);
        tz(H[3]) cube_round([d,d,e], rr, center=true);
        tz(H[4]) cylinder(h=e, d=d, center=true);
        tz(H[5]) cylinder(h=e, d=d, center=true);
      }
      cube([I, I, 20], true);
      tz(H[4]) hull() { cube([I+1,I+1,e], true); cube([I,I,1], true);}
      tower([o-e, 2.5, 3.5], [sqrt(2)*I,sqrt(2)*I,I]);
    }
  }
}


*tx(40) ty(-10) BB20female(H=8);

module BB20female(o=gapv, H=10)
{
  Z=[0, 0.6, 2.2, 2.8, 4.4, 5];
  d=D0+2*o;   
  rr = R0+o;
  D=sqrt(2)*(D0-2*R0)+2*R0;
  
  tz(H/2) cube_round([d,d,H], rr, center=true);
  
  hull_tower()
  {
    tz(Z[0]) cube_round([d+1,d+1,e], rr, center=true);//cylinder(h=e, d=d, center=true);
    tz(Z[1]) cube_round([d,d,e], rr, center=true);//cylinder(h=e, d=d, center=true);
    tz(Z[4]) cube_round([d,d,e], rr, center=true);//cylinder(h=e, d=d, center=true);
    tz(Z[5]) cube_round([d+1,d+1,e], rr, center=true);//cylinder(h=e, d=d, center=true);
  }
  hull_loop()
  {
    tz(Z[1]) cylinder(h=Z[4]-Z[1], d=d);
    tz(Z[2]) cylinder(h=Z[3]-Z[2], d=D-(ddd-o));
    tz((Z[2]+Z[3])/2) rotz(45) cube_round([d,d,Z[3]-Z[2]], rr, center=true);
    tz((Z[2]+Z[3])/2)  cube_round([d,d,Z[3]-Z[2]], rr, center=true);
    
  }
}

