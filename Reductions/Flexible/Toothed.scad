$fa = 0.1;
$fs = 0.1;

module Rack(pitch=1,pressure_angle=20,aspect=1){
  p = pitch;
  r = aspect;
  a = pressure_angle;
  polygon([[-p*r,-p*r/2]
	   ,[-tan(a)*p*r/2,-p*r/2]
	   ,[tan(a)*p*r/2,p*r/2]
	   ,[p*r,p*r/2]
	   ,[p*r,-p*r*2]
	   ,[-p*r,-p*r*2]]);
  };

module HalfTooth(pitch=1,pressure_angle=20,aspect=1,n=20){
  p = pitch;
  r = n*p/2;
  difference(){
  translate([0,-r])square([1*pitch,1*pitch*aspect],center=true);
  for (i = [-180/n:4:180/n]){
    rotate(-i)translate([r*i*PI/180,-r])color("red")Rack(pitch=p,pressure_angle=pressure_angle,aspect=aspect);
  };
  };
};

/* rotate(-360/14)HalfTooth(pitch=50,aspect=1,n=14); */
/* mirror([1,0])translate([-50/2,0])HalfTooth(pitch=50,aspect=1,n=14); */
%circle(d=20*50);
rotate(360/20/2)HalfTooth0(pitch=50,aspect=1,n=20);
HalfTooth0(pitch=50,aspect=1,n=20);
/* Rack0(pitch=50,pressure_angle=40); */

module mirror_copy(v = [1, 0, 0]) {
    children();
    mirror(v) children();
}

module Rack0(pitch=1,pressure_angle=20){
  p = pitch;
  a = pressure_angle;
  r = p/2/tan(a);
  polygon([[-p/2,r/2]
	   ,[0,-r/2]
	   ,[p/2,r/2]
	   /* ,[p/2,-r/2] */
	   /* ,[-p/2,-r/2]	    */
	   ]);
  };

module HalfTooth0(pitch=1,pressure_angle=20,aspect=1,n=20){
  p = pitch;
  r = n*p/2;
  /* difference(){ */
  /* translate([0,-r])square([1*pitch,1*pitch*aspect],center=true); */
  intersection_for (i = [-180/n:1:180/n]){
    rotate(-i)translate([r*i*PI/180,-r])color("red")Rack0(pitch=p,pressure_angle=pressure_angle);
  /* }; */
  };
};
