include <mjk.scad>
w=4.6;
W=11;

PART()BB20Tool1();
PART(25)BB20Tool2();
PART(50)BB20Tool3();
PART(75)BB20Tool4();

module BB20Tool1()
{
  rotx(-90) difference()
  {
    tz(w/2)
    {
      ty(-5) hull()
      {
        cubec([w,9,w], [1,1,1]/3, true);
        cube([w-1,10,w-1], true);
      }
      difference()
      {
        rotx() tower([0, 1, 10, 15, 40, 45, 70, 72], [19, 20, 20, 15, 15, 20, 20, 17]);
        cube(W, true);
        hull()
        {
          cube([W+2, 0.1, W+2], true);
          cube([W, 2, W], true);
        }
      }
    }
  }
}

module BB20Tool2()
{
  difference()
  {
    tower([0, 2, 40, 45, 70],[18, 20, 20, 11, 11]);
    tz(50+5) cube([5,5,100], true);
  }
}

module BB20Tool3()
{
  H=6;
  D=35;
  e=0.1;
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
}

module BB20Tool4()
{  
  difference()
  {
    tower([0, 1, 10, 15, 40, 45, 70, 72], [20, 20, 20, 15, 15, 20, 20, 17]);
    cube_round([16, 16, 11], 3, true);
  }
  
}


*difference()
{
  tz(w/2)
  {
    hull()
    {
      cubec([w,20,w], [1,1,1]/3, true);
      cube([w-2,24,w-2], true);
    }
    difference()
    {
      ty(-20) cube_round3([20, 40, 20],3, true);
      cube(W, true);
      hull()
      {
        cube([W+2, 0.1, W+2], true);
        cube([W, 2, W], true);
      }
    }
  }
  //tz(-100) cube(200, true);
    
}
*hull() { tx(-w/2) ty(-w) cube(w); tx(-10) cube_round3([20, 40, 10],2);}