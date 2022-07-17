/* $fa=1; */
/* $fs=1; */
$fa=0.3;
$fs=0.1;
$t=0;
use <../../Utils/ProperlySpacedBelts.scad>;
use <../../Utils/Utils.scad>;

module UpperRing(){
  translate([0,0,2])
  difference(){
    union(){
      translate([8+(66+3)/PI-10/2,0,0])cylinder(d=10,center=true,h=2);
      cylinder(d=8+(66+3)*2/PI,center=true,h=2);
      };
    cylinder(d=(66+3)*2/PI,center=true,h=100);
    linear_extrude(100,center=true,convexity=10)
      round(0,0.5)
      /* offset(r=0.05) */
      RoundGT2(66+3,360,inverted=true);
  };
};

module LowerRing(){
  translate([0,0,-2])
  difference(){
    union(){
      translate([8+(66+2)/PI-10/2,0,0])cylinder(d=10,center=true,h=2);
      cylinder(d=8+(66+2)*2/PI,center=true,h=2);
      };
    cylinder(d=(66+2)*2/PI,center=true,h=100);
    linear_extrude(100,center=true,convexity=10)
      round(0,0.5)
      /* offset(r=0.05) */
      RoundGT2(66+2,360,inverted=true);
  };
};
t0 = 784*$t;
i = 360*t0;

color("SteelBlue",0.8)LowerRing();
color("LimeGreen",0.8)
/* rotate(i*(1-69/66)) */
rotate(i*(3/69))
rotate(-i*(2/68)-0.254*360/69)
UpperRing();
/* rotate(-t0*360*105/2346+360*-0.25/69)UpperRing(); */
/* (/ 1 (- (/ 3 69.0)(/ 2 68.0))) */
/* (/ 1 (- (/ 3 69.0)(/ 2 68.0))) */
rotate(-i*(2/68))
union(){
  color("salmon",1.0)
  translate([0,0,-3/2])
    linear_extrude(3,center=true,convexity=10)
    rotate(i)
    multmatrix(M0)
    rotate(-i)
    RoundGT2(66,360,phase=0.5,inverted=true);
  translate([0,0,3/2])
    linear_extrude(3,center=true,convexity=10)
    TriRoundGT2(66,360,phase=0.5,inverted=true,out=0.0456,triPhase=-3*i);
};

/* translate([0,0,-3])linear_extrude(3,convexity=2)RoundGT2(66+3,360,inverted=false); */
/* linear_extrude(3,convexity=2)RoundGT2(66+2,360); */


tUb = 62.4961;
dUpperBearing = tUb*2/PI;
/* echo(dUpperBearing); */
tLb = 60.7442;
dLowerBearing = tLb*2/PI;
/* echo(dLowerBearing); */

s=0.03;
M0 = [ [ 1+s  , 0  , 0  , 0   ],
       [ 0  , 1-s  , 0, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

/* cc = getCenterDist(t,t,66,tol=0.00001); */
/* echo("CC:",cc); */
/* overall = t*2/PI+cc; */
/* echo("overall:",overall); */
/* target = 2 * 69 / PI; */
/* echo("delta:",target-overall); */

module TriRoundGT2(teeth=20,angle=90,phase=0,inverted=false,out=0,triPhase=0){
  difference(){
      union(){
        /* difference(){ */
        /*   circle(r=teeth/PI-0.254+1.38-0.75); */
        /*   circle(r=teeth/PI-0.254); */
        /* }; */
        for (i=[-360/teeth:360/teeth:angle]){
          rotate(i+(phase%1 * 360/teeth))
            translate([0,(-teeth/PI)*(1+sin(3*i+triPhase)*out),0])
            rotate(out*exp(1+out)*(-180/PI)*cos(3*i+triPhase))
            render()
            rotate(inverted ? 180 : 0)
            round(0.2,0)
            GT2Unit(fill_gap=0.3);
        };
      };
      Sector(teeth,[270,270+angle]);  
    };
  };
