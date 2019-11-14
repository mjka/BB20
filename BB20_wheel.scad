use <mjk.scad>
use <BB20.scad>
$fs=0.1;
e=0.01;


PART(0,0,0)  BB20_SimpleWheel(80);
PART(60,-20,0)  BB20_SimpleWheel(40);

module PART(x=0, y=0, z=0)
{
  translate([x,y,z]) children();
}

module BB20_SimpleWheel(D=40)
{
  difference()
  {
    union()
    {
      cylinder(h=4.5, d=19);
      
      difference()
      {
        cylinder(h=16, d=D, $fa=2);
        cylinder(h=40, d=D-4, $fa=2, center=true);
      }
    }
    cube_round([10.3,10.3,40], 2, true);
  }
  for (a=[0:30:360]) rotz(a) tx(9) ty(-1) cube([D/2-10,  3, 3]);
}