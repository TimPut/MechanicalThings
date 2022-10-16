include </home/tim/3dprinting/chamfer.scad>;

$fn=400;
$fs=0.01;
$fa=0.01;
module slot(d,h){
    translate([0,d/2])circle(d=d);
    translate([0,h/2])square([d,h-d],center=true);
    translate([0,h-d/2])circle(d=d);
};

p0 = 65;
p1 = 50;
p2 = 30;
t = 7;

module Kinematic(d=10){
    translate([0,0,-0.01])
    for (i = [0:360/(3):360]){
        linear_extrude(height=3)union(){
        rotate(i)translate([-1.9,d])slot(2,14);
        rotate(i)translate([1.9,d])slot(2,14);
        };
        linear_extrude(height=7.2)union(){
        rotate(i)translate([0,d])slot(2,10);
        };
    };
};

color("salmon")translate([0,0,-10])
difference(){
linear_extrude(height=t,convexity=10)difference(){
    square(p0*2+30,center=true);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(8):360]) {
            rotate(i)translate([0,p0+5])circle(d=2);
    };
        for (i = [0:360/(12):360]) {
            rotate(i)translate([0,25.4])circle(d=2);
    };

}
};
for(i=[0:90:270]){
    rotate(i)translate([p0,p0,0])cylinder(d=5,h=20);};
Kinematic(5);
Kinematic(40);
};


!color("green")linear_extrude(height=t,convexity=10)difference(){
    circle(d=p0*2+30);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(5):360]) {
            rotate(i)translate([0,p1+5])circle(d=2);
    };

    for (i = [0:360/(8):360]){
        rotate(i)translate([-4,p0])slot(2,10);
        rotate(i)translate([0,p0])slot(1.5,10);
        rotate(i)translate([4,p0])slot(2,10);
    }
}
};


translate([0,0,10])linear_extrude(height=t,convexity=10)difference(){
    circle(d=p1*2+30);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(9):360]) {
            rotate(i)translate([0,p2+5])circle(d=2);
    };

    for (i = [0:360/(5):360]){
        rotate(i)translate([-4,p1])slot(2,10);
        rotate(i)translate([0,p1])slot(1.5,10);
        rotate(i)translate([4,p1])slot(2,10);
    }
}
};

color("purple")translate([0,0,20])
difference(){
    linear_extrude(height=t,convexity=10)difference(){
    circle(d=p2*2+30);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(12):360]) {
            rotate(i)translate([0,25.4])circle(d=2);
    };

    for (i = [0:360/(9):360]){
        rotate(i)translate([-4,p2])slot(2,10);
        rotate(i)translate([0,p2])slot(1.5,10);
        rotate(i)translate([4,p2])slot(2,10);
    }
}
};
/* Kinematic(5); */
};
