include <BB20.scad>
include <MCAD/servos.scad>

type="";
GUI=1;

///# BB20 electronics
///## Pinout
/// * Pin 1: SCL1 
/// * Pin 2: Servo-PWM 
/// * Pin 3: SDA 
/// * Pin 4: Motor- (or GND) 
/// * Pin 5: Motor+ (or VBat  max. +12V)      
/// * Pin 6: GND 
/// * Pin 7: 5V 
/// * Pin 8: GND DATA 
/// * Pin 9: NeoPixel-IN 
/// * Pin 10: NeoPixel-OUT 


PART() BB20Servo();
//PART(100) BB20Light();
//PART(0) BB20Motor();
PART(-30, -30) BB20MotorFlansch();


//tx(40) alignds420([0,0,0], 0, screws = 0, axle_lenght = 0);

module ServoM(spos, a=0)
{
  translate(spos) ty(40) my() futabas3003([0,0,0],a);
}

module BB20Servo()
{
  dim=[1,4,3];
  spos=[0, 20, 10];
  
  difference()
  {
    BB20Cube(dim);
    ty(60) BB20females([1,1,3], [[1,1], [0,1], [0,1]], H=5.4);
    tz(40) BB20females([1,1,1], [both, [1,0], [0,0]], H=5.4);
    tz( 0) BB20females([1,4,1], [none, none, [1,0]], H=5.4);
    tz(40) ty(40) BB20females([1,1,1], [none, none, [0,1]], H=5.4);
    tz(40)  BB20females([1,1,1], [none, none, [0,1]], H=5.4);
    // Servo + Clearance
    translate(spos+[0,-8, 27])  cube([20, 56, 4]);  
    translate(spos+[0,-0.5,-2]) cube([20, 41, 40]);
    translate(spos+[0,5,35])   cube([20, 10, 10]);
    futabas3003(spos, 0);
    // Stecker:
    tz(30) tx(2) roty() WSG([1,1,1]);
    color("red") tx(10) ty(20) tz(19) cube([18, 15, 30], true);
    color("purple") translate(spos+[5,-8,2])  cube([26, 10, 6]);
    //color("purple") translate(spos+[10,22,0])  cube([6, 55, 12], true);
    // Schrauben:
    for (x=[5,15]) for(y=[-4,44]) translate(spos+[x,y,0]) 
    {
      cylinder(h=60, d=3);
      tz(28) cylinder(h=30, d=7);
    }
    // Flansch
    translate(spos+[10,10,35]) cylinder(h=20, d=16);
  }
  //if (GUI) color("black")  ServoM(spos, 0);
    ty(60) BB20supportFemales([1,1,3], [[1,1], [0,1], [0,1]]);
    tz(40) BB20supportFemales([1,1,1], [both, [1,0], [0,0]]);

  translate(spos+[0.5,1,-1.5]) SupportCube([19, 38, 39]);
  translate(spos+[0.5,-2,28]) SupportCube([19, 44, 2.5]);
  translate([10,10.5,20]) SupportCube([3, 4, 16.5], true);
}



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
    cylinder(h=20, d=2);
  }
}

//module DeckelSchnitt(dim, o)
//{
//  o3=[o,o,o];
//  
//  difference()
//  {
//    translate(-o3) tz(dim.z*20-20) cubec(20*[dim.x,dim.y,1]+2*o3,[1,1,1]);
//    ty(dim.y*10) cmy() ty(dim.y*-10) // vorne und hinten
//    translate(-o3) tz(dim.z*20-20) ty(-e) hull() {
//      cube([dim.x*20+2*o, e,  20+2*o]);
//      tx(5) ty(5) cube([dim.x*20-10+2*o, e, 15+2*o]);
//    }
//    translate(-o3) tz(dim.z*20-20) tz(-e) hull() {
//      cube([dim.x*20+2*o,dim.y*20+2*o, e]);
//      tx(5) ty(5) cube([dim.x*20-10+2*o, dim.y*20-10+2*o, 5+e]);
//    }
//  }
//}
//
//tx(100) CubeSchnitt([2,2,2], -0);


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
    translate(o3+[5,0,40]) cube(dim*20+2*o3-[10,0,5]);
    translate(o3+[5,60,hh]) cube(dim*20+2*o3-[10,0,5]);
//    *difference()
//    {
//      translate(o3+[5,0,5]) cube(dim*20+2*o3-[10,0,5]);
//      children();
//    }
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
  //echo($children);
  intersection()
  {
    CubeSchnitt(dim, -gapd, hh) // kleiner
    {
      children(3);
    }
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
      CubeSchnitt(dim, gapd, hh) children(3); // groeser
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
      tz( 0) BB20females([dim.x, dim.y, 1], [both, [1,1], [1,0]], H=5.4);
      tz(20) BB20females([dim.x, dim.y, 1], [both, [1,0], none], H=5.4);
      tz(40) BB20females([dim.x, dim.y, 1], [both, [0,1], [0,1]], H=5.4);
      //BB20females(dim-[0,0,1], [none, [1,0], none], H=5.4);
      ty(5) BB20females(dim-[0,1/2,1], [none, both, none], H=5.4);   
      WSG(dim);
      tx(30) ty(70) tz(30) rotz(-90) Getriebemotor();  
      tx(30) ty(70) tz(30) roty() cylinder(h=dim.x*20, d=16, center=true);
      tx(30) ty(70) tz(30) roty() cylinder(h=dim.x*20-10 , d=18, center=true);
      tx(30) tz(30) ty(20) cube([50, 20, 47], true);
    }
    union() {
      tz( 0) BB20supportFemales([dim.x, dim.y, 1], [both, none]);
      tz(20) BB20supportFemales([dim.x,     3, 1], [both, none]);
      tz(40) BB20supportFemales([dim.x, dim.y, 1], [both, none]);
    }
    union() {
      tz( 0) BB20supportFemales([dim.x, dim.y, 1], [none, [1,1]]);
      tz(20) BB20supportFemales([dim.x, dim.y, 1], [none, [1,0]]);
      tz(40) BB20supportFemales([dim.x, dim.y, 1], [none, [0,1]]);
    }
    union() {
      translate(o3+[5,0,30]) cube(dim*20+2*o3-[10,0,5]);
      //cube([dim.x*20, 60, 40]);
      //cube([dim.x*20, dim.y*20, dim.z*10]); 
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