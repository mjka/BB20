


include <mjk.scad>
w=4.6;
W=11;
e=0.01;

difference()
{
  cylinder(d=20, h=20, $fa=2); 
  cube_round([16, 16, 10], 3, true);
  
}
  
  
//  
//  tz(w/2)
//  {
//    hull()
//    {
//      cubec([w,20,w], [1,1,1]/3, true);
//      cube([w-2,24,w-2], true);
//    }
//    difference()
//    {
//      ty(-20) cube_round3([20, 40, 20],3, true);
//      cube(W, true);
//      hull()
//      {
//        cube([W+2, 0.1, W+2], true);
//        cube([W, 2, W], true);
//      }
//    }
//  }
//  //tz(-100) cube(200, true);
//    
//}
//*hull() { tx(-w/2) ty(-w) cube(w); tx(-10) cube_round3([20, 40, 10],2);}