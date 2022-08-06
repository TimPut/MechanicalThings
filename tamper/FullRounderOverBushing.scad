$fa=0.5;
$fs=0.5;

module RouterBit(shaft=0.5*25.4,radius=0.5*25.4,height=3/4*25.4,diam=1.5*25.4){
  
  color("silver")cylinder(d=shaft,h=2*25.4);
  color("green")difference(){
    translate([0,0,0])cylinder(d=diam,h=height);
    rotate_extrude()translate([diam/2,0,0])circle(r=radius);
  };
};

module BeadingBearing(d=3/8*25.4,h=3/16*25.4,clearance=0.2){
  cylinder(d=d+clearance,h=h+clearance);
  cylinder(d=d-1,h=h*2);
};

module Bushing(shaft=0.5*25.4,radius=0.5*25.4,height=3/4*25.4,diam=1.5*25.4,bush_diam=0.75*25.4){
  color("orange")
  difference(){
    mirror([0,0,1])translate([0,0,2])
      difference(){
      cylinder(d=bush_diam,h=5/16*25.4);
      BeadingBearing();
    };
    translate([0,0,0.1])rotate_extrude()translate([diam/2,0,0])circle(r=radius);
  };
};

module Display(){
  translate([0,0,30])mirror([0,0,1]){
    mirror([0,0,1])color("silver")BeadingBearing();
    RouterBit();
    Bushing();
  };
module Print(){
    Bushing();
  };

Print();
