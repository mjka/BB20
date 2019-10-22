include <mjk.scad>

difference() 
{
  tower([0,1, 6, 7], [28, 30, 30,28]);
  tz(-1) ty(-25) tx(-8) cube_round([16, 30, 10], 3);
}
tx(-7.5) ty(6) cubec([15, 80, 7], [2,2,2]);