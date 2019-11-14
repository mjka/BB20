use <mjk.scad>
use <BB20.scad>
$fs=0.1;
e=0.01;


D0 = 10; // Size of peg
R0 = 2; // Corner radius of peg
I = 5; // Inner hole inside the peg


 hull_tower()
      {
        rr = 4;
        d = (19 - 2*rr) / sqrt(2) + 2*rr;  
        tz(0) cube_round([d-2,d-2,e], rr-1, center=true);
        tz(1) cube_round([d,d,e], rr, center=true);
        tz(4) cube_round([d,d,e], rr, center=true);
        tz(5+e) cube_round([d-2,d-2,e], rr-1, center=true);
      }


tz(5) difference()
{
  cube_round([D0,D0,10], R0, center=true);
  tz(0) rotz(45) hull_tower() {
    cylinder(d=D0, h=e); 
    tz(5) cube_round([D0,D0,e], R0, true); 
    tz(10) cube_round([D0,D0,e], R0, true); 
  }
  //tz(7) rotz(45) cube_round([D0,D0,10], R0, true);
  //tz(7) rotz(45) cube_round([D0,D0,10], R0, true);
  rotz(45) BB20male();
}
tz(5)  rotz(45) hull() { cube([I-1,I-1,10], true);cube([I,I,8], true);}