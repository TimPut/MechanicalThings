include <threads.scad>;
$fn=120;
o = 25.4 * (3/8 - 1/4)/2;

/*
  Second Roundover Cup 
*/
/* difference(){ */
/*   linear_extrude(height=15+3) */
/*     offset(r=-0.5) */
/*     projection(cut = true)rotate([90,0,0]) */
/*     tamp(); */
/*   union(){ */
/*     #translate([35.5,-24,0])rotate([0,0,-40])translate([-10,0,-2.3-3])cube([100,50,30],center=true); */
/*     scale([1,1,1])translate([0,0,-3])rotate([90,0,0])tamp(); */
/*     }; */
/* }; */
/*
  intersection(){
  union(){
    };
  scale([1,1,1])translate([0,0,0])rotate([90,0,0])tamp();
};
*/

module tamp(){
    union(){
    intersection(){
      /* scale([0.98,1,1]) */
      cube([300,30,300],center=true);
      scale([30/30,25.4/30,1])
      scale([0.98,1.0,1])
        translate([-15.45,0,59.275])
        rotate([90,0,0])
        import("./untitled-Sli3R.stl", convexity=3);
    };
    /* translate([0,0,-3])cylinder(d=30,h=3); */
    };
};

module tampThreadedHole(){
    difference(){
    intersection(){
      /* scale([0.98,1,1]) */
      cube([300,30,300],center=true);
      scale([30/30,25.4/30,1])
      scale([0.98,1.0,1])
        translate([-15.45,0,59.275])
        rotate([90,0,0])
        import("./untitled-Sli3R.stl", convexity=3);
    };
    #translate([0,0,-3])english_thread (diameter=1/4, threads_per_inch=20, length=1);
    };
};



tampThreadedHole();
