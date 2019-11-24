include <BB20.scad>

type="";
GUI=1;

//PART(100) BB20Light();
PART(0) BB20Motor();
PART(-30, -30) BB20MotorFlansch();

module BB20MotorFlansch()
{
  difference()
  {
    union()
    {
      cylinder(d=15, h=19);
      cylinder(d=17, h=14);
    }
    cube([3.9, 5.5, 18], true);
    tz(10+6) cube_round([D0,D0,12], R0, true);
  }
}

module DeckelSchnitt(dim, o)
{
  o3=[o,o,o];
  
  difference()
  {
    translate(-o3) tz(dim.z*20-20) cubec(20*[dim.x,dim.y,1]+2*o3,[1,1,1]);
    ty(dim.y*10) cmy() ty(dim.y*-10) // vorne und hinten
    translate(-o3) tz(dim.z*20-20) ty(-e) hull() {
      cube([dim.x*20+2*o, e,  20+2*o]);
      tx(5) ty(5) cube([dim.x*20-10+2*o, e, 15+2*o]);
    }
    translate(-o3) tz(dim.z*20-20) tz(-e) hull() {
      cube([dim.x*20+2*o,dim.y*20+2*o, e]);
      tx(5) ty(5) cube([dim.x*20-10+2*o, dim.y*20-10+2*o, 5+e]);
    }
  }
}

tx(100) CubeSchnitt([2,2,2], -0);


module CubeSchnitt(dim, o, hh=20)
{
  o3=[o,o,o];  
  difference()
  {
    translate(-o3) cubec(20*dim+2*o3,[1,1,1]);
    
    ty(dim.y*10) cmy() ty(dim.y*-10) // vorne und hinten
    translate(-o3) ty(-e) hull() {
      cube([dim.x*20+2*o, e, dim.z*20+2*o]);
      tx(5) ty(5) tz(5) cube([dim.x*20-10+2*o, e, dim.z*20-5+2*o]);
    }
    translate(-o3) tz(dim.z*20) hull() { // oben
      cube([dim.x*20+2*o,dim.y*20+2*o, e]);
      tx(5) ty(5) tz(-5-e) cube([dim.x*20-10+2*o, dim.y*20-10+2*o, 5+e]);
    }
    translate(o3+[5,0,hh]) cube(dim*20+2*o3-[10,0,5]);
  }
}

module BB20Deckel(dim)
{
  intersection()
  {
    difference() {
      BB20Cube(dim);
      BB20females(dim, [both, none, [0,1]], H=5.4); 
      //ty(5) BB20females(dim-[0,0.5,0], [none, both, none], H=5.4);
      //ty(10) BB20Cube(dim-[0,0.75,0.25]);
    }
    CubeSchnitt(dim, -gapd);
  }
}

module Schneider(dim, hh=20)
{
  
  intersection()
  {
    CubeSchnitt(dim, -gapd, hh); // kleiner
    union()
    {
      children(0);
      children(1);
    }
  }
  
  tz(dim.z*20) tx(-5) roty(180) 
  {
    difference()
    {
      union() 
      { 
        children(0); 
        children(2);
      }
      CubeSchnitt(dim, gapd, hh); // groeser
    }
  }
}

module BB20Motor()
{
  dim=[3,4,3];
  
  Schneider(dim, dim.z*10) 
  {
    difference()
    {
      BB20Cube(dim);
      BB20females(dim, [both, [0,1], both], H=5.4);
      BB20females(dim-[0,0,1], [none, [1,0], none], H=5.4);
      ty(5) BB20females(dim-[0,1/2,1], [none, both, none], H=5.4);   
      WSG(dim);
      tx(30) ty(70) tz(30) rotz(-90) Getriebemotor();  
      tx(30) ty(70) tz(30) roty() cylinder(h=dim.x*20, d=16, center=true);
      tx(30) ty(70) tz(30) roty() cylinder(h=dim.x*20-10, d=18, center=true);
      tx(30) tz(30) ty(20) cube([50,20, 50], true);
    }
    {
      BB20supportFemales(dim, [both, none]);
    }
    {
      BB20supportFemales(dim, [none, both]);
    }
  }
  
  

  //tz(50) BB20Deckel(dim);
  *difference()
  {
    BB20Cube(dim);
    CubeSchnitt(dim, gapd);
    
    
    BB20females(dim, [both, both, both], H=5.4);

  }
  if (GUI)  tx(30) ty(70) tz(30)  rotz(-90)   Getriebemotor();
}

module WSG(dim)
{
  
    tx(dim.x*10)  tz(dim.z*20-12)
    {
     ty(6) rotx() WSG10(0.2);
     tz(5) hull() { cube([25, e, 35], true);cube([20, 2, 30], true);}
     hull() { cube([25, 1, 15], true);cube([20, 10, 10], true);}
   }
 }


module BB20Light(dim=[2, 2, 2])
{
  difference()
  {
    BB20Cube(dim);
    BB20females(dim, [both, none, both], H=5.4);
    BB20females([dim.x, dim.y, dim.z-1], [none, [1,0], none], H=5.3);
    WSG(dim);
//    tx(dim.x*10)  tz(dim.z*20-12)
//    {
//     ty(6) rotx() WSG10(0.2);
//     tz(5) hull() { cube([25, e, 35], true);cube([20, 2, 30], true);}
//     hull() { cube([25, 1, 15], true);cube([20, 10, 10], true);}
//   }

    translate(dim*10) ty(10) cube(dim*20-[13,0,13], true);
    
    tx(dim.x*10) ty(dim.y*20) tz(dim.z*10) 
    {
      hull()
      {
        ty(-10) cube([dim.x*20-18, e, dim.z*20-18], true);
        cube([dim.x*20-5, e, dim.z*20-5], true);
      }
      ty(-2-1) cube([dim.x*20-4, 2, dim.z*20-4], true);
    }
  }
  BB20supportFemales(dim, [both, none, both]);
   BB20supportFemales([dim.x, dim.y, dim.z-1], [none, [1,0], none]);
  Support() translate(dim*10) ty(dim.y*10-6) cube([dim.x*20-13, 0.5, dim.z*20-13], true);
}