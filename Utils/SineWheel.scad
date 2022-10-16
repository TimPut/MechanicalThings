$fa=0.1;
$fs=0.1;

module SineWheel(n=600,teeth=20, r=1, a=0.033){
  points = [ for (theta = [0:360/n:360]) [(r+r*a*sin(theta*teeth))*sin(theta)
				      ,(r+r*a*sin(theta*teeth))*cos(theta)]];
  polygon(points);
  };


module HypotrochoidWheel(n=1000,teeth=17, r=1, a=0.5){
  r0 = r;
  r1 = r0 / teeth;
  d0 = a * r1;
  points = [ for (theta = [0:360/n:360]) [(r0-r1)*cos(theta)+d0*cos(theta*(r0-r1)/r1)
					  ,(r0-r1)*sin(theta)-d0*sin(theta*(r0-r1)/r1)]];
  polygon(points);
  };

/* Hypotrochoid(); */


/* a=0.05*$t;
a=0.05*0.66;
t = $t*31;

module Outer(){
    difference(){
    circle(r=1.2);
    SineWheel(n=500,teeth=31,a=a);
  };
};


module Inner(){
  color("salmon")
    rotate([0,0,t*360*(29/31-1)])
    rotate([0,0,t*360])
    scale([1,31/29.1])
    rotate([0,0,-t*360])
    difference(){
    SineWheel(n=500,teeth=29,r=1*29/31,a=a);
    circle(r=26/31);
    };
};

linear_extrude(height=1,convexity=10)
union(){
  Outer();
  Inner();
};
 */
