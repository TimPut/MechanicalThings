$fn=400;
$fs=0.01;
$fa=0.01;
module slot(d,h){
    hull(){
    translate([0,d/2])circle(d=d);
    translate([0,h-d/2])circle(d=d);
    };
};

p0 = 80;
p1 = 60;
p2 = 40;

linear_extrude(height=5)difference(){
    circle(d=210);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(5*3):360]) {
            rotate(i)translate([0,p1+10])circle(d=2);
    };

    for (i = [0:360/(8*2):360]){
        rotate(i)translate([-4,p0])slot(2,20);
        rotate(i)translate([0,p0])slot(1.5,20);
        rotate(i)translate([4,p0])slot(2,20);
    }
}
};


translate([0,0,10])linear_extrude(height=5)difference(){
    circle(d=170);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(9*5):360]) {
            rotate(i)translate([0,p2+10])circle(d=2);
    };

    for (i = [0:360/(5*3):360]){
        rotate(i)translate([-4,p1])slot(2,20);
        rotate(i)translate([0,p1])slot(1.5,20);
        rotate(i)translate([4,p1])slot(2,20);
    }
}
};

translate([0,0,20])linear_extrude(height=5)difference(){
    circle(d=130);
    union(){
    /* for (i = [0:360/(8*7):360]){ */

        for (i = [0:360/(8):360]) {
            rotate(i)translate([0,20])circle(d=2);
    };

    for (i = [0:360/(9*2):360]){
        rotate(i)translate([-4,p2])slot(2,20);
        rotate(i)translate([0,p2])slot(1.5,20);
        rotate(i)translate([4,p2])slot(2,20);
    }
}
};
