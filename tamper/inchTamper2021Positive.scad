use <../Utils/Utils.scad>;
include <../Utils/threads.scad>;
$fa=0.1;
$fs=0.1;

module tamp(){
      scale([30/30,25.4/30,1])
      scale([0.98,1.0,1])
        translate([-15.45,0,59.275])
        rotate([90,0,0])
        import("./BaseModelTamper.stl", convexity=3);
};

linear_extrude(6.35)round(0.5,8)projection()rotate([90,0,0]){
  tamp();
  };
/* translate([0,0,-20])english_thread(diameter=3/8, threads_per_inch=16, length=1, internal=true); */
