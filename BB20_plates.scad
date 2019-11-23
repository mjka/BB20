include <mjk.scad>
include <BB20.scad>

type ="";

PART( 0,0,0) BB20Plate([1,2]);

*union() {
  PART() BB20Plate([1,3]);
  PART() BB20Plate([1,4]);
  PART() BB20Plate([2,2]);
  PART() BB20Plate([2,4]);
  PART() BB20Plate([4,4]);
  PART() BB20Plate([4,8]);
}

PART(25,0,0) BB20PlateR([1,4]);

*union() {
  PART() BB20PlateR([1,3]);
  PART() BB20PlateR([1,4]);
  PART() BB20PlateR([2,2]);
  PART() BB20PlateR([2,4]);
}

PART(50,0,0) BB20Panel([2,2,1]);

*union() {
  PART() BB20Panel([1,2,1]); 
  PART() BB20Panel([1,3,1]); 
  PART() BB20Panel([1,4,1]); 
  
  PART() BB20Panel([2,4,1]); 
  PART() BB20Panel([4,4,1]);
}


module BB20Panel(dim=[1,2,1], H=10.01, gapd=gapd, gapv=gapv)
{
  
  g3=[gapd,gapd,gapd];
  difference()
  {
    translate(g3) union()
    {
      cubec([5,dim.y*20,dim.z*20]-2*g3, 1.0*[1,1,1]);
      cubec([dim.x*20,5,dim.z*20]-2*g3, 1.0*[1,1,1]);
      tx(dim.x*20-5) cubec([5,dim.y*20,dim.z*20]-2*g3, 1.0*[1,1,1]);
      ty(dim.y*20-5) cubec([dim.x*20,5,dim.z*20]-2*g3, 1.0*[1,1,1]);
      tx(1) ty(1) cube([20*dim.x-2, 20*dim.y-2, 1]);
    }
    BB20females(dim=dim, pos=[both, both, none], H=H);
  }
  BB20supportFemales(dim=dim, pos=[both, both, none]);
}



module BB20Plate(dim=[1,1], gapd=gapd, gapv=gapv)
{  
  g3=[gapd,gapd,gapd];
  difference()
  {
    translate(g3) cubec([20*dim.x, 20*dim.y, 5]-2*g3, 1.0*[1,1,1]);
    for (x=[1:dim.x]) for (y=[1:dim.y]) translate([20*x-10, 20*y-10, 10]) 
      tz(-10) BB20female(gapv);
   }
}


module BB20PlateR(dim=[1,1], h=4, gapd=gapd, gapv=gapv)
{  
  g3=[gapd,gapd,gapd];
  difference()
  {
    x = dim.x*20-2*gapd;
    r = (4*h*h + x*x) / (8 * h); d=2*r;
    intersection()
    {
      translate(g3) cubec([20*dim.x, 20*dim.y, 10]-2*g3, 1.0*[1,1,1]);
      tz(5+h-r) tx(x/2) rotx(-90) 
        tower([gapd, 1+gapv, dim.y*20-1-gapv, dim.y*20-gapv], [d-2, d, d, d-2], $fn=200);
    }
    for (x=[1:dim.x]) for (y=[1:dim.y]) translate([20*x-10, 20*y-10, 10]) 
      tz(-10) BB20female(gapv+gapv2, H=5.5);
    }
}


//u|WSL10();
//WSG10();