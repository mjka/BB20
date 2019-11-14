include <mjk.scad>

H=6;
D=35;
e=0.1;

*union()
{
  difference() 
  {
    tower([0,1, H-1, H], [D-2, D, D, D-2]);
    tz(-1) ty(-25) tx(-8) cube_round([16, 30, H+2], 3);
  }
  tx(-5) ty(6) cubec([10, 80, H], [2,2,2]);
}

union()
{
  difference() 
  {
    D=25;
    tower([0,1, H-1, H], [D-2, D, D, D-2]);
    tz(1) ty(-24) tx(-8) cube_round([16, 30, 6], 3);
  }
  tx(-5) ty(6) cubec([10, 80, H], [2,2,2]);
}

*union() 
{
  difference() 
  {
    tz(H/2) hull()
    {
      cube_round([20, 20, H], 3, true);
      cube_round([22, 22, H-2], 3, true);
    }
    hull_tower()
    {
      tz(0) cube_round([18, 18, e], 3, true);
      tz(1) cube_round([16, 16, e], 3, true);
      tz(H-1) cube_round([16, 16, e], 3, true);
      tz(H) cube_round([18, 18, e], 3, true);
    }
    //tower([0,1, H-1, H], [D-2, D, D, D-2]);
    //cube_round([16, 16, 3*H], 3, true);
  }
  tx(-5) ty(8) cubec([10, 80, H], [2,2,2]);
}




