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
///
///All devices need to connect Pin 9 and Pin 10.



PART() BB20MotoBitBottom();
PART(100) BB20MotoBitTop();
//PART() BB20Servo();
//PART(100) BB20Light();
//PART(0) BB20Motor();
//PART(-30, -30) BB20MotorFlansch();
//PART() BB20BoxA([2,5,3], lock=true);
//PART(50) BB20BoxB([2,5,3]);


module BB20BoxA(dim, o=-gapd, lock=false)
{
  d=dim*20;
  difference()
  {
    BB20Cube(dim);
    
    // Center
    tx(10+o) ty(5+o) tz(5+o) cube([d.x-20-2*o, d.y-10-2*o, d.z]);
    if (!lock) ty(5+o) tz(5+o) cube([d.x, d.y-10-2*o, d.z]);
    // Top
    tz(dim.z*20+o) hull() {
      tz(o) cube([d.x, d.y, 10]);
      tx(5+o) ty(5+o) tz(-5) cube([d.x-10-2*o, d.y-10-2*o, e]);
    }
    // Sides
    tx(dim.x*10) cmx() tx(dim.x*-10) hull() {
      tx(-5-2*o) cube([5, d.y, d.z]);
      ty(5) tx(5-o) tz(5+o) cube([e, d.y-10-2*o, d.z-5-o]);
    } 
  }
}

module BB20BoxB(dim, o=-gapd, lock=true)
{
  d=dim*20;
  difference()
  {
    BB20Cube(dim);
    
    // Center
    tx(5+o) ty(10+o) tz(5+o) cube([d.x-10-2*o, d.y-20-2*o, d.z]);
    if (!lock) tx(5+o) tz(5+o) cube([d.x-10-2*o, d.y, d.z]);

    // Top
    tz(dim.z*20+o) hull() {
      tz(o) cube([d.x, d.y, 10]);
      tx(5+o) ty(5+o) tz(-5) cube([d.x-10-2*o, d.y-10-2*o, e]);
    }
    // Front and back
    ty(dim.y*10) cmy() ty(dim.y*-10) hull() {
      ty(-5-2*o) cube([d.x, 5, d.z]);
      tx(5) ty(5-o) tz(5+o) cube([d.x-10-2*o, e, d.z-5-o]);
    } 
  }
}
module BB20MotoBitBottom()
{  
  dim=[4,5,2];
  mpos = [40, 12, 8];    
  if (GUI)   translate(mpos) color("darkgrey") moto_bit();
  difference()
  {      
    union()
    {
      BB20BoxA(dim);
      //translate(mpos+[0,42,-2]) cube([68,82,8], true); 
      tx(5.5) ty(1) tz(1) cube([68, 98, 8]);
      tx(5.5) ty(1) tz(0.5) cube([60-7, 9, 34]);
    }
    //#tx(1) ty(10) tz(8) cube([58, 80, 40]);
    ctx([-20, 5]) WSG(dim); 
    translate(mpos) color("darkgrey") moto_bit();
    BB20females([4,5,1], [none, [1,0], [1,0]], H=5.4);
    tz(20) ty(80) BB20females([4,1,1], [none, [0,1], none], H=5.4);
  }
}

module BB20MotoBitTop()
{  
  dim=[4,5,2];
  mpos = [40, 12, 8];    
  union()
  {
    if (GUI) tx(80) tz(40) roty(180) translate(mpos)  color("darkgrey") moto_bit();

    difference()
    {
      union()
      {
        BB20BoxB(dim);
      }     
      //tx(5) ty(1) tz(1) cube([69, 98, 8]);
      tx(20) ty(5) tz(5) cube([60-5, 9, 34]);
      
      BB20females([4,1,2], [[0,1], none, none], H=5.4);
      tx(20) BB20females([3,1,1], [none, none,[1,0]], H=5.4);
      ty(20) BB20females([4,3,2], [[1,0], none, [1,0]], H=5.4);
      
      ty(20) BB20females([4,3,1], [[0,1], none, none], H=5.4);
      ty(40) tz(20) BB20females([4,2,1], [[0,1], none, none], H=5.4);
      
      ty(5) BB20females([1,1,2], [none, [1,0], none], H=5.4);
      ty(75) BB20females([4,1,1], [none, [0,1], none], H=5.4);
      tx(5) ty(10) tz(20) cube([70, 100, 20]);
      tx(50) ty(30) tz(25) #roty() cylinder(d=15, h=60);

    }      
    ty(20) BB20supportFemales([4,3,2], [[1,0], none, both]);
     BB20supportFemales([4,1,2], [[0,1], none, both]);
      ty(20) BB20supportFemales([4,3,1], [[0,1], none, none]);
      ty(40) tz(20) BB20supportFemales([4,2,1], [[0,1], none, none]);
  }  
}

module moto_bit(gap=0.4)
{
  // Platine
  tx(-58.4/2-gap) cube([58.4+2*gap, 53.6+2*gap, 2.5]);
  tx(-54/2) ty(31) cube([54, 22, 11.5]);
  tx(-54/2) ty(10) cube([54, 40, 6]);
  
  // Schalter
  tx(-13/2) ty(7) cube([13, 5, 12]);
  // Stromstecker
  tx(-58.4/2-3) ty(14) tz(1.8) cube([14, 9, 11]);
  tx(-58.4/2-2) ty(18.2) tz(7.7) roty(-90) cylinder(h=20, d=10);
  
  // micro:bit Stecker
  tx(-34.5/2-gap) cube([34.5+2*gap, 76.4+2*gap, 2.5]);
  tx(-58.4/2-gap) ty(60-gap) cube([58.4+2*gap, 16.5+2*gap, 11.5]);
  tx(-57.0/2-gap) ty(60-gap) tz(1.8) cube([58.4+2*gap, 21.2+2*gap, 8.6]);
  tx(-52.0/2-gap) ty(75) tz(5) cube([52+2*gap, 40, 2.5]);
  
  // THT Loetstellen
  ty(65) cube([57, 10, 4], true);
  ty(17) cube([57, 10, 4], true);
  ty(24) cube([15, 35, 4], true);
}

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
    children();
//    translate(o3+[5,0,40]) cube(dim*20+2*o3-[10,0,5]);
//    translate(o3+[5,60,hh]) cube(dim*20+2*o3-[10,0,5]);
//    *difference()
//    {
//      translate(o3+[5,0,5]) cube(dim*20+2*o3-[10,0,5]);
//      children();
//    }
  }
}
//
//module BB20Deckel(dim)
//{
//  intersection()
//  {
//    difference() {
//      BB20Cube(dim);
//      BB20females(dim, [both, none, [0,1]], H=5.4); 
//      //ty(5) BB20females(dim-[0,0.5,0], [none, both, none], H=5.4);
//      //ty(10) BB20Cube(dim-[0,0.75,0.25]);
//    }
//    CubeSchnitt(dim, -gapd);
//  }
//}

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
      CubeSchnitt(dim, gapd, hh) children(4); // groeser
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
      o3=gapd*[1,1,1];
    translate(-o3+[5,10,30]) cube(dim*20+2*o3-[10,0,5]);
    translate(-o3+[5, 0,40]) cube(dim*20+2*o3-[10,0,5]);
    //translate(-o3+[5,60,30]) cube(dim*20+2*o3-[10,0,5]);
    }
    union(){
      o3=-gapd*[1,1,1];
    translate(-o3+[5,0,30]) cube(dim*20+2*o3-[10,0,5]);
    //translate(-o3+[5,60,30]) cube(dim*20+2*o3-[10,0,5]);
    }
      //translate(o3+[5,0,30]) cube(dim*20+2*o3-[10,0,5]);
      //cube([dim.x*20, 60, 40]);
      //cube([dim.x*20, dim.y*20, dim.z*10]); 
  
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