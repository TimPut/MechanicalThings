use <../../Utils/ProperlySpacedBelts.scad>;
use <../../Utils/Utils.scad>;
use <../../Utils/Bearings.scad>;



$fa=0.5;
$fs=0.5;
/* Set $t=0 for animation on the command line */
/* $t=0; */

/* 1:300 */
/* n = 22; */

/* 1:3240 */
n = 20;

nPrime = n + 1;
toothDelta = 2;
/* Base Pitch */
p = 5.5;
soft=p/4;

module UpperRing(h=2,buffer=1){
  translate([0,0,h/2-0.01])
  difference(){
    union(){
      translate([8+(nPrime)/PI-10/2,0,0])cylinder(d=10,center=true,h=h);
      cylinder(d=8+(nPrime)*2/PI,center=true,h=h-0.01);
      };
    cylinder(d=(nPrime+toothDelta)*2/PI,center=true,h=100);
    translate([0,0,-h/2+buffer/2])cylinder(d=(nPrime+6)*2/PI,center=true,h=buffer);
    linear_extrude(100,center=true,convexity=10)
      round(0,0.5)
      /* offset(r=0.05) */
      RoundGT2(nPrime+toothDelta,360,pitch=p*(n+toothDelta)/(nPrime+toothDelta),inverted=true);
  };
};

module UpperRingTri(h=2,buffer=1){
  translate([0,0,h/2-0.01]){
    difference(){
      union(){
        Herringbone(h,360/nPrime)
        /* linear_extrude(h,center=true,convexity=10) */
	  InnerSawtoothRing(nPrime+toothDelta,pitch=p*(n+toothDelta)/(nPrime+toothDelta),soften=soft);
      difference() {
        union() {
          /* translate([p/2*(nPrime)/PI+5,0,0])cylinder(d=10,center=true,h=h); */
          cylinder(d=4*p+(nPrime)*p/PI,center=true,h=h-0.01);
          /* cylinder(d=45-0.2,center=true,h=h-0.01); */
        };
        cylinder(d=p+(nPrime+toothDelta)*p/PI,center=true,h=100);
        };
      };
      translate([0,0,-h/2+buffer/2-0.001])cylinder(d=(nPrime+6)*p/PI,center=true,h=buffer);
    };
  };
};

module LowerRingTri(h=2,buffer=1,plate=5){
  translate([0,0,-h/2-0.01]){
    difference(){
      union(){
	Herringbone(h,360/n)
	  /* linear_extrude(h,center=true,convexity=10) */
	  InnerSawtoothRing(n+toothDelta,pitch=p,soften=soft);
	  translate([0,0,-h/2-plate/2+0.02])cylinder(d=4*p+(nPrime)*p/PI,center=true,h=plate);

	difference(){
	  union(){
	    translate([p/2*(nPrime)/PI+5,0,0])cylinder(d=10,center=true,h=h);
	    cylinder(d=4*p+(nPrime)*p/PI,center=true,h=h-0.01);
	  };
	  cylinder(d=4+(nPrime+toothDelta)*p/PI,center=true,h=100);
	};
      };
      translate([0,0,-h/2-plate])Nema17MountTemplate();
      translate([0,0,h/2-buffer/2+0.001])cylinder(d=(nPrime+6)*p/PI,center=true,h=buffer);
    };
  };
};

module LowerRing(h=2,buffer=1,plate=3){
  translate([0,0,-h/2+0.01])
    union(){
    /* difference(){ */
    /* translate([0,0,-h/2-plate/2+0.02])cylinder(d=8+(nPrime)*2/PI,center=true,h=plate); */
    /* translate([0,0,-h/2-plate])Nema17MountTemplate(); */
    /* }; */
    difference(){
      union(){
        translate([8+(nPrime)/PI-10/2,0,0])cylinder(d=10,center=true,h=h);
        cylinder(d=8+(nPrime)*2/PI,center=true,h=h-0.01);
      };
      cylinder(d=(n+toothDelta)*2/PI,center=true,h=100);
      translate([0,0,+h/2-buffer/2])cylinder(d=(nPrime+6)*2/PI,center=true,h=buffer);
      linear_extrude(100,center=true,convexity=10)
        round(0,0.5)
        /* offset(r=0.05) */
        RoundGT2(n+toothDelta,360,pitch=p,inverted=true);
    };
  };
};
module LowerSpline(h=3,phase=0.5){
  color("salmon",1.0)
    rotate(-i*(1-(n/(n+toothDelta))))
    translate([0,0,-h/2])
    linear_extrude(h,center=true,convexity=10)
    rotate(i)
    multmatrix(M0)
    rotate(-i)
    RoundGT2(n,360,pitch=2,phase=phase,inverted=true);
  };

module LowerSplineTri(h=3,phase=0.5){
  color("salmon",1.0)
    rotate(-i*(1-(n/(n+toothDelta))))
    translate([0,0,-h/2])
    /* linear_extrude(h,center=true,convexity=10) */
    rotate(i)
    multmatrix(M0)
    rotate(-i)
    Herringbone(h,360/n)
    rotate(phase*1/n)
    offset(r=-0.2)
    difference(){
    SawtoothRing(n,p,soften=soft);
      circle(d=n*p/PI-1.4);
    };
  };

module UpperSplineTri(h=3,phase=0.5){
  color("salmon",1.0)
    rotate(-i*(1-(n/(n+toothDelta))))
    translate([0,0,h/2])
    /* linear_extrude(h,center=true,convexity=10) */
    rotate(i)
    multmatrix(M1)
    rotate(-i)
    Herringbone(h,360/nPrime)
    rotate(phase*1/n)
    offset(r=-0.2)
    difference(){
    SawtoothRing(nPrime,p*(n+toothDelta)/(nPrime+toothDelta),soften=soft);
      circle(d=n*p/PI-1.4);
    };
  };

module UpperSpline(h=3,phase=0.5){
  color("salmon",1.0)
    rotate(-i*(1-(n/(n+toothDelta))))
    translate([0,0,h/2])
    linear_extrude(h,center=true,convexity=10)
    rotate(i)
    multmatrix(M1)
    rotate(-i)
    RoundGT2(nPrime,360,pitch=2*(n+toothDelta)/(nPrime+toothDelta),phase=phase,inverted=true);
  };

module Elliptical(pitch=p,h=10){
  difference(){
    multmatrix(M0)
      cylinder(d=pitch*n/PI-2,h=h,center=true);
    translate([0,0,-10])Nema17ShaftWFlat();
    };
  };

ratio = -(1/((1-(nPrime/(nPrime+toothDelta)))-(1-(n/(n+toothDelta))))+1);
ratioAlternativeDeriv = 1/(toothDelta/(n+toothDelta)-toothDelta/(nPrime+toothDelta))-1;
echo("Ratio:",ratio);
/* echo("Ratio:",ratioAlternativeDeriv); */
assert(abs(ratio - ratioAlternativeDeriv)<0.0001);

t0 = ratio*$t;
i = 360*t0;

/* manually tweaked eccentricity */
/* (/ 70 68.0) */
/* s0=0.054; */
s0 = (n+toothDelta)/n - 1;
/* echo(s0); */
/* s0=0.0; */
M0 = [ [ 1+s0  , 0  , 0  , 0   ],
       [ 0  , 1-s0  , 0, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

/* s1=0.04; */
/* s1=s0; */
/* s1=0.0; */
s1 = (nPrime+toothDelta)/nPrime - 1;
/* echo(s1); */
M1 = [ [ 1+s1  , 0  , 0  , 0   ],
       [ 0  , 1-s1  , 0, 0   ],
       [ 0  , 0  , 1  , 0   ],
       [ 0  , 0  , 0  , 1   ] ] ;

/* UpperSpline(h=10,phase=0); */
/* LowerSpline(h=10,phase=0); */
union(){
UpperSplineTri(h=h,phase=0);
LowerSplineTri(h=h,phase=0);
};
translate([0,0,0*20])
color("SteelBlue",1)LowerRingTri(h=h,buffer=1);

/* color("LimeGreen",1) */
/* intersection(){ */
/*   rotate(+i*(1-(nPrime/(nPrime+toothDelta)))) */
/*     rotate(-i*(1-(n/(n+toothDelta)))) */
/*     UpperRingTri(h=10,buffer=2); */
/*   rotate(25)translate([0,-50,-50])cube([100,100,100]); */
/*   }; */
translate([0,0,0*20])
color("LimeGreen",1)rotate(+i*(1-(nPrime/(nPrime+toothDelta))))rotate(-i*(1-(n/(n+toothDelta))))UpperRingTri(h=h,buffer=1);

/* /\* Nema17MountTemplate(); *\/ */
translate([0,0,0*20])
rotate(i)
rotate(-i*(1-(n/(n+toothDelta))))
color("white")Elliptical(h=10);
translate([0,0,h])B6809(center=false,clearance=0.2);
translate([0,0,-22])Nema17Motor();
 
h=7;
