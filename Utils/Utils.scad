module round(a,b,chamfer=false){
  offset(a,chamfer=true)offset(-b-a)offset(b) children();
    };
module chamfer(a,b,chamfer=false){
  offset(delta=a,chamfer=true)offset(-b-a)offset(b) children();
    };


module Nema17Motor(){
  difference(){
    union(){
      color("silver")
        difference(){
        cylinder(d=5,h=24);
        translate([-5,2,4])cube([10,10,24]);
      };
      color("silver")cylinder(d=22,h=2);
      color([0.2,0.2,0.2])mirror([0,0,1])linear_extrude(height=48)chamfer(6,0)square([42.3,42.3],center=true);
      };
    for (i=[0:90:360]){
      rotate(i)translate([31/2,31/2,0])cylinder(d=3,h=20,center=true);
      };
    }
  };

module Nema17MountTemplate(){
    union(){
      color("silver")
        difference(){
        cylinder(d=5.05,h=25);
        translate([-5,2.05,6])cube([10,10,24]);
      };
      color("silver")cylinder(d=23.2,h=20.3);
      color([0.2,0.2,0.2])mirror([0,0,1])linear_extrude(height=48)round(2,0)square([42.3,42.3],center=true);
    for (i=[0:90:360]){
      rotate(i)translate([31/2,31/2,0])cylinder(d=3.6,h=20,center=true);
      rotate(i)translate([31/2,31/2,2])cylinder(d=8,h=20,center=false);
      };
      };
    };

module Nema17ShaftWFlat(){
  color("silver")
    difference(){
    cylinder(d=5.3,h=25);
    translate([-5,2.2,6])cube([10,10,24]);
  };
  };

module Herringbone(h,t){
  union(){
    translate([0,0,h/4])linear_extrude(height=h/2,twist=t,center=true, convexity=10)children();
    translate([0,0,-h/4])linear_extrude(height=h/2,twist=-t,center=true, convexity=10)children();
  };
};



module InnerSawtoothRing(n=78,pitch=2,t=1,soften=0.4){
  pitch_circle_diam = n * pitch / PI;
  d = pitch_circle_diam;
  s=pitch+t;
  difference(){
    circle(d=d+s*2);
    SawtoothRing(n,pitch,soften);
  };
};    
module SawtoothRing(t=78,pitch=2,soften=0.4){
  n = t*2;
  pitch_circle_diam = t * pitch / PI;
  r = pitch_circle_diam/2;
  s=pitch*0.707;
  points = [for (i=[0:n]) [(r+s*(i%2))*cos(360*i/n),(r+s*(i%2))*sin(360*i/n)]
    ];
  round(soften,soften)
  polygon(points);
  };

