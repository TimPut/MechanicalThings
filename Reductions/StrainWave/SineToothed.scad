$fs=0.1;
$fa=0.1;

use <../../Utils/SineWheel.scad>;
use <../../Utils/Utils.scad>;
use <../../Utils/Bearings.scad>;


twistRate = 0;
th=39;
r=16;
c = 0;
p = r / th;
echo(p);
// Tooth shape clearance
/* a = (1-1/(th))/(th+1); */
a = 0.6;
// Reduction of first halfstage
s = 2/th;
// Reduction of second halfstage in isolation
q = 2/(th+1);
// Reduction of compound stage; note that the effective deformation
// speed of the second stage is reduced by the tangential motion of
// the spline
ratio = (2/(s*q)+2/s);
// One full cycle in [0,1)
t = ratio*$t*360;
echo(ratio);
wall = r*0.08;

bbr=4.5-(r-1)*(th+2)/th;
translate([4.5-(r-wall)*(th+2)/(th),0,3])B684();
module Arm(){
  linear_extrude(height=1)
    difference(){
    hull(){
      translate([0,bbr])circle(d=6);
      translate([0,-bbr])circle(d=6);
      translate([0,0])circle(d=20);
    };
    circle(d=5.2);
  };
  linear_extrude(height=3)
  union(){
    translate([0,bbr])circle(d=3.8);
    translate([0,-bbr])circle(d=3.8);
  };

};

strained = 1;
split = 0;
rotate(90)Arm();
/* color("yellow",0.3)translate([50*split,0,5])rotate(t/ratio)MobileRing(); */
translate([-50*split,0,-0.2])color("blue",1)FixedRing();
Spline();

module FixedRing(){
  mirror([0,0,1])linear_extrude(height=3)
    difference(){
    square(42,center=true);
    circle(d=23);
    for (x=[0,90,180,270]){
      rotate(x)translate([31/2,31/2])circle(d=3.6);
      };    
  };
  linear_extrude(height=3.2, twist=twistRate*(3.2*4), slices=10)
  difference(){
    circle(r=r+3);
    HypotrochoidWheel(teeth=th+2,r=(th+2)*p+c,a=a);
    };
  };

module MobileRing(){
  translate([0,0,3.2])
  linear_extrude(height=4)
    difference(){
    circle(r=r+5);
    circle(d=13.6);
    for (x=[0:360/6:360]){
      rotate(x)translate([13,0])circle(r=4);
      };
  };
  linear_extrude(height=3.2, twist=twistRate*(3.2*4), slices=10)
  difference(){
    circle(r=r+5);
    HypotrochoidWheel(teeth=th+3,r=(th+2)*p+c,a=a);
    };
  };




module Spline(){
  rotate(-t)
  scale([(strained*(th+2)/th)+1-strained,(strained*(th)/(th+2))+1-strained,1])
  rotate(t)
  rotate(t*(s))
  union(){
    color("yellow",1)
    linear_extrude(height=3, twist=twistRate*(3*4), slices=10)
      difference(){
      HypotrochoidWheel(teeth=th,r=r,a=a);
      circle(r=r-wall);
    };
    color("orange",1)
    translate([0,0,3])
      linear_extrude(height=2)
      difference(){
      circle(r=r+a*r/th+1);
      circle(r=r-wall);
    };    
    color("red",1)
    translate([0,0,5])
      linear_extrude(height=3, twist=twistRate*(3*4), slices=10)
      difference(){
      HypotrochoidWheel(teeth=th+1,r=r,a=a);
      circle(r=r-wall);
    };
  };
};




translate([0,0,-3])Nema17Motor();

/* translate([0,0,2+5+3+0.2])B695(); */
