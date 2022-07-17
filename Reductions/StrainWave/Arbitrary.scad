use <../../Utils/ProperlySpacedBelts.scad>;
use <../../Utils/Utils.scad>;

$fa=1;
$fs=0.1;
/* Set $t=0 for animation on the command line */
/* $t=0; */

/* 1:300 */
/* n = 22; */

/* 1:3240 */
n = 78;

nPrime = n + 1;

/* Base Pitch */
p = 2;

module UpperRing(){
  translate([0,0,2-0.01])
  difference(){
    union(){
      translate([8+(nPrime)/PI-10/2,0,0])cylinder(d=10,center=true,h=2);
      cylinder(d=8+(nPrime)*2/PI,center=true,h=2-0.01);
      };
    cylinder(d=(nPrime+2)*2/PI,center=true,h=100);
    linear_extrude(100,center=true,convexity=10)
      round(0,0.5)
      /* offset(r=0.05) */
      RoundGT2(nPrime+2,360,pitch=p*(n+2)/(nPrime+2),inverted=true);
  };
};

module LowerRing(){
  translate([0,0,-2+0.01])
  difference(){
    union(){
      translate([8+(n+2)/PI-10/2,0,0])cylinder(d=10,center=true,h=2);
      cylinder(d=8+(n+2)*2/PI,center=true,h=2-0.01);
      };
    cylinder(d=(n+2)*2/PI,center=true,h=100);
    linear_extrude(100,center=true,convexity=10)
      round(0,0.5)
      /* offset(r=0.05) */
      RoundGT2(n+2,360,pitch=2,inverted=true);
  };
};

module LowerSpline(){
  color("salmon",1.0)
    rotate(-i*(1-(n/(n+2))))
    translate([0,0,-3/2])
    linear_extrude(3,center=true,convexity=10)
    rotate(i)
    multmatrix(M0)
    rotate(-i)
    RoundGT2(n,360,pitch=2,phase=0.5,inverted=true);
  };


module UpperSpline(){
  color("salmon",1.0)
    rotate(-i*(1-(n/(n+2))))
    translate([0,0,3/2])
    linear_extrude(3,center=true,convexity=10)
    rotate(i)
    multmatrix(M1)
    rotate(-i)
    RoundGT2(nPrime,360,pitch=2*(n+2)/(nPrime+2),phase=0.5,inverted=true);
  };


ratio = -(1/((1-(nPrime/(nPrime+2)))-(1-(n/(n+2)))));
ratioAlternativeDeriv = 1/(2/(n+2)-2/(nPrime+2));
echo("Ratio:",-ratio);
assert(abs(ratio - ratioAlternativeDeriv)<0.0001);

t0 = ratio*$t;
i = 360*t0;

/* manually tweaked eccentricity */
s0=0.025;
M0 = [ [ 1+s0  , 0  , 0  , 0   ],
       [ 0  , 1-s0  , 0, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

s1=0.025;
M1 = [ [ 1+s1  , 0  , 0  , 0   ],
       [ 0  , 1-s1  , 0, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

UpperSpline();
LowerSpline();

color("SteelBlue",1)LowerRing();

color("LimeGreen",0.9)
intersection(){
  rotate(+i*(1-(nPrime/(nPrime+2))))
    rotate(-i*(1-(n/(n+2))))
    UpperRing();
  rotate(25)translate([0,-50,-50])cube([100,100,100]);
  };

color("LimeGreen",0.2)
  rotate(+i*(1-(nPrime/(nPrime+2))))
  rotate(-i*(1-(n/(n+2))))
  UpperRing();
