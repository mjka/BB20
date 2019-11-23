include <BB20.scad>

type ="";

PART( 0,0,0) BB20PlainBearing();
PART(25,0,0) BB20BallBearing();
PART(50,0,0) BB20BallBearingS();
PART(75,0,0) BB20BallBearingSide();
PART(125,0,0) BB20BallBearingSide2();
PART(-20,0,0) BB20BearingInsert();

module BB20BearingInsert()
{
  difference()
  {
    union()
    {
      cylinder(d=23.5, h=1.5);
      cylinder(d=17, h=2); 
      tower([0,18,18,19], [14.8, 14.8, 15.5,13.5]);
    }
    hull_tower()
    {
      tz(0) cube_round([D0+2,D0+1,e], R0, center=true);
      tz(1) cube_round([D0,D0,e], R0, center=true);
      tz(18) cube_round([D0,D0,e], R0, center=true);
      tz(19) cube_round([D0+1,D0+1,e], R0, center=true);
    }
    intersection()
    {
      cube([D0-0.8, 40, 50], true);
      tz(-1) cylinder(d=19.1, h=50);
    }
  }
}

module BB20PlainBearing(dim=[1,3,1], H=40.01)
{
  D1 = 12.7;
  g3=[gapd,gapd,gapd];
  difference()
  {
    translate(g3)  cubec(20*dim-2*g3, 1.0*[1,1,1]);
   
    ty( 0) BB20females(dim=[1,1,1], pos=[both, [1,0], both], H=H);
    ty(40) BB20females(dim=[1,1,1], pos=[both, [0,1], both], H=H);
    
    tz(10) ty(30) roty() tower([0,1,19,20], [D1+1,D1,D1,D1+1]);
    tx(10) ty(30) tower([0,1,19,20], [D1+1,D1,D1,D1+1]);
  }
  ty( 0) BB20supportFemales(dim=[1,1,1], pos=[both, [1,0], both]);
  ty(40) BB20supportFemales(dim=[1,1,1], pos=[both, [0,1], both]);
}

module BB6802outer()
{ 
  roty() tower([gapd,1,19,20-gapd], [28,29,29,28]);
}

module BB6802inner()
{
  roty() cylinder(d=16, h=20);
  tx(10) cmx() tx(-10)
  {
    roty() cylinder(d=24+gapd, h=7.5);
    roty() cylinder(d=22, h=8);
    roty() cylinder(d1=25, d2=24+gapd, h=1);
  }
   
}

module BB20BallBearing(dim=[1,3,1], H=40.01)
{
  g3=[gapd,gapd,gapd];
  difference()
  {
    union()
    {
      translate(g3)  cubec(20*dim-2*g3, 1.0*[1,1,1]);
      ty(30) tz(30) BB6802outer();
    }
    ty( 0) BB20females(dim=[1,1,1], pos=[none, [1,0], [0,1]], H=60);
    ty( 0) BB20females(dim=[1,3,1], pos=[both, [1,1], [1,0]], H=16);
    ty(40) BB20females(dim=[1,1,1], pos=[none, [0,1], [0,1]], H=60);
    
    ty(30) tz(30) BB6802inner();
  }
  ty( 0) BB20supportFemales(dim=dim, pos=[both, both, both]);
}
module BB20BallBearingSide(dim=[1,3,1], H=40.01)
{
  g3=[gapd,gapd,gapd];
  difference()
  {
    union()
    {
      translate(g3)  cubec(20*dim-2*g3, 1.0*[1,1,1]);
      tx(30) ty(30) tz(20) roty() BB6802outer();
    }
    ty( 0) BB20females(dim=[1,1,1], pos=[both, [1,0], both], H=60);
    ty(20) BB20females(dim=[1,1,1], pos=[[1,0], none, both], H=16);
    ty(40) BB20females(dim=[1,1,1], pos=[both, [0,1], both], H=60);
    
    tx(30) ty(30) tz(20) roty() BB6802inner();
  }
  //ty( 0) BB20supportFemales(dim=dim, pos=[both, both, both]);  
  ty( 0) BB20supportFemales(dim=[1,1,1], pos=[both, [1,0], both]);
  ty(20) BB20supportFemales(dim=[1,1,1], pos=[[1,0], none, both]);
  ty(40) BB20supportFemales(dim=[1,1,1], pos=[both, [0,1], both]);
  tx(30) ty(30) tz(gapv) difference() {
    cylinder(d=16, h=7.2);cylinder(d=15.2, h=20, center=true);
  }
}

module BB20BallBearingSide2(dim=[1,3,1], H=40.01)
{
  g3=[gapd,gapd,gapd];
  difference()
  {
    union()
    {
      translate(g3)  cubec(20*dim-2*g3, 1.0*[1,1,1]);
      tx(10) ty(30) tz(20) roty() BB6802outer();
    }
    ty( 0) BB20females(dim=[1,1,1], pos=[both, [1,0], both], H=11);
    //ty(20) BB20females(dim=[1,1,1], pos=[[1,0], none, both], H=16);
    ty(40) BB20females(dim=[1,1,1], pos=[both, [0,1], both], H=11);
    
    tx(10) ty(30) tz(20) roty() BB6802inner();
  }
  //ty( 0) BB20supportFemales(dim=dim, pos=[both, both, both]);  
  ty( 0) BB20supportFemales(dim=[1,1,1], pos=[both, [1,0], both]);
  //ty(20) BB20supportFemales(dim=[1,1,1], pos=[[1,0], none, both]);
  ty(40) BB20supportFemales(dim=[1,1,1], pos=[both, [0,1], both]);
  tx(10) ty(30) tz(gapv) difference() {
    cylinder(d=16, h=7.2);cylinder(d=15.2, h=20, center=true);
  }
}
module BB20BallBearingS()
{
  g3=[gapd,gapd,gapd];
  difference()
  {
    union()
    {
      translate(g3)  cubec([20,60,5]-2*g3, 1.0*[1,1,1]);
      ty(30) tz(15) BB6802outer(); 
    }

    ty( 0) BB20females(dim=[1,1,1], pos=[none,none,[1,0]], H=60);
    ty(40) BB20females(dim=[1,1,1], pos=[none,none,[1,0]], H=60);
    
    ty(30) tz(15) BB6802inner();
//    { 
//      roty() cylinder(d=16, h=20);
//      roty() cylinder(d=24.4, h=7);
//      tx(20-7)  roty() cylinder(d=24.4, h=7);
//      roty() tower([0,1,10,19,20], [26,24.4,1,24,4,26]);
//    }
  }
}


module BB20Bearing(dim=[1,3,1], H=40.01)
{
  g3=[gapd,gapd,gapd];
  difference()
  {
    translate(g3)  cubec(20*dim-2*g3, 1.0*[1,1,1]);
   
    ty( 0) BB20females(dim=[1,2,1], pos=[both, [1,0], both], H=H);
    ty(40) BB20females(dim=[1,1,1], pos=[both, [0,1], both], H=H);
    tz(10) ty(30) roty() tower([0,1,19,20], [15,13,13,15]);
  }
  ty( 0) BB20supportFemales(dim=[1,1,1], pos=[both, [1,0], both]);
  ty(40) BB20supportFemales(dim=[1,1,1], pos=[both, [0,1], both]);
}

