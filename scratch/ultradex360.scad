/* include </home/tim/3dprinting/chamfer.scad>; */

$fn=40;
$fs=0.01;
$fa=0.01;
module slot(d,h){
    hull(){
    translate([0,d/2])circle(d=d);
    translate([0,h-d/2])circle(d=d);
    };
};

p0 = 65;
p1 = 35;
p2 = 25;
t = 7;

Base();
Ring1();
Ring2();
Ring3();

module slots(p){
    translate([-2.6,p])slot(1.8,10);
    translate([0,p])slot(1.8,10);
    translate([2.6,p])slot(1.8,10);
};

module Kinematic(d=10){
    translate([0,0,-0.01])
    for (i = [0:360/(3):360]){
        linear_extrude(height=2.01)union(){
        rotate(i)translate([-2,d])slot(2,14);
        rotate(i)translate([2,d])slot(2,14);
        };
        linear_extrude(height=7.2)union(){
        rotate(i)translate([0,d])slot(2.01,14);
        };
    };
};

module Base(){
color("salmon",0.5)translate([0,0,-10])
difference(){
linear_extrude(height=t,convexity=10)difference(){
    square(p1*2+30,center=true);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(8):360]) {
            rotate(i)translate([0,p2+5])circle(d=2);
    };
        for (i = [0:360/(12):360]) {
            rotate(i)translate([0,20])circle(d=2);
    };

}
};
for(i=[0:90:270]){
    rotate(i)translate([p0,p0,0])cylinder(d=5,h=20);};
rotate(1/17*360)Kinematic(5);
rotate(-1/17*360)Kinematic(32);
};
};

module Ring1(){
color("green",0.5)linear_extrude(height=t,convexity=10)difference(){
    circle(d=p1*2+30);
    union(){
        for (i = [0:360/(5):360]) {
            rotate(i)translate([0,p1+5])circle(d=2);
    };

    for (i = [0:360/(8):360]){
        rotate(i)slots(p2);
    }
}
};
};

module Ring2(){
color("tan",0.5)translate([0,0,10])linear_extrude(height=t,convexity=10)difference(){
    circle(d=p1*2+30);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(9):360]) {
            rotate(i)translate([0,p2+5])circle(d=2);
    };

    for (i = [0:360/(5):360]){
        rotate(i)slots(p1);
    }
}
};
};

module Ring3(){
color("purple",0.5)translate([0,0,20+7])
mirror([0,0,1])
difference(){
    linear_extrude(height=t,convexity=10)difference(){
    circle(d=p2*2+30);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(12):360]) {
            rotate(i)translate([0,20])circle(d=2);
    };

    for (i = [0:360/(9):360]){
        rotate(i)slots(p2);
    }
}
};
rotate(1/17*360)Kinematic(5);
};
};
