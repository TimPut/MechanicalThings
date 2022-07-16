$fs=0.1;
$fa=0.1;

module TwoPulleyBelt(num_teeth_0,num_teeth_1,num_teeth_belt,phase=0,pitch=2){
  // TODO: phases are wrong below
  center_to_center = getCenterDist(num_teeth_0,num_teeth_1,num_teeth_belt,pitch);
  echo("Center to center distance:", center_to_center);
  radius_0 = num_teeth_0*pitch/(2*PI);
  radius_1 = num_teeth_1*pitch/(2*PI);
  beta = asin((radius_0-radius_1)/center_to_center);
  phase_offset = (sqrt(center_to_center^2+(radius_0-radius_1)^2) / pitch)%1;
  angle_phase = (PI*beta/(180*pitch));
  echo(beta);
  StraightGT2(num_teeth_0,[0,0],num_teeth_1,[center_to_center,0],phase,pitch);
  StraightGT2(num_teeth_0,[0,0],num_teeth_1,[center_to_center,0],1-phase,pitch,flip=true);

  rotate(180+beta)
    RoundGT2(num_teeth_1,180-2*beta,phase%1);

  translate([center_to_center,0])
    rotate(-beta)
    RoundGT2(num_teeth_0,180+2*beta,(0.5+phase+(PI*beta/(360*pitch))+phase_offset)%1);
  };

module GT2Unit(fill_gap=0){
  GT2Half(fill_gap);
  mirror([1,0,0])GT2Half(fill_gap);
  };

module GT2UnitTooth(fill_gap=0){
  GT2HalfTooth(fill_gap);
  mirror([1,0,0])GT2HalfTooth(fill_gap);
  };

module GT2Half(fill_gap=0){
  intersection(){
    union(){
      intersection(){
        translate([0.4,0.254,0])circle(r=1);
        square(1.38,center=true);
      };
      translate([0,0.254,0])mirror([1,1,0])square([1.38-0.75,1+fill_gap]);
      translate([0,0.254+0.75-0.555,0])circle(r=0.555);
      translate([-0.588,0.254,0])difference(){
        square([0.3,0.26],center=true);
        translate([-0.15,0.15,0])circle(r=0.15);
        };
    };
  translate([0,-0.376,0])mirror([1,0,0])square(2);
  };
  };

module GT2HalfTooth(fill_gap=0){
  intersection(){
    union(){
      intersection(){
        translate([0.4,0.254,0])circle(r=1);
        square(1.38,center=true);
      };
      translate([0,0.254,0])mirror([1,1,0])square([1.38-0.75,1+fill_gap]);
      translate([0,0.254+0.75-0.555,0])circle(r=0.555);
      translate([-0.588,0.254,0])difference(){
        square([0.3,0.26],center=true);
        translate([-0.15,0.15,0])circle(r=0.15);
        };
    };
  translate([0,0,0])mirror([1,0,0])square(2);
  };
  };

module RoundGT2(teeth=20,angle=90,phase=0,inverted=false){
    difference(){
      union(){
        difference(){
          circle(r=teeth/PI-0.254+1.38-0.75);
          circle(r=teeth/PI-0.254);
        };
        for (i=[-360/teeth:360/teeth:angle]){
          rotate(i+(phase%1 * 360/teeth))
            translate([0,-teeth/PI,0])
            render()
            rotate(inverted ? 180 : 0) 
            GT2UnitTooth();
        };
      };
      Sector(teeth,[270,270+angle]);  
    };
  };

module StraightGT2(num_teeth_0,c0,num_teeth_1,c1,phase=0,pitch=2,flip=false){
  quad = (c0.x - c1.x)^2 + (c0.y - c1.y)^2;
  radius_0 = num_teeth_0 * pitch / (2*PI);
  radius_1 = num_teeth_1 * pitch / (2*PI);
  straight = sqrt(quad - (radius_0 - radius_1)^2);
  alpha = atan((c0.y-c1.y)/(c0.x-c1.x));
  beta = asin((radius_1-radius_0)/sqrt(quad));
  side = flip ? 1 : 0 ;
  rotate(alpha)mirror([0,side])rotate(beta)
    intersection(){
      for (i = [-2*pitch:pitch:straight+2*pitch]){
        translate([i+phase%1*pitch,-radius_1])GT2Unit();
      };
      translate([0,-radius_1-20/2])square([straight,20]);
    };
};

module Sector(radius, angles, fn = 3) {
    r = radius / cos(180 / fn);
    step = -360 / fn;
    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );
    polygon(points);
};

/* Computes center to center distance betwee two pulleys of given pitch
   circle radius with given belt length */
function getCenterDist(num_teeth_0,num_teeth_1,num_teeth_belt,pitch=2,tol=0.001) =
  let (belt_length = num_teeth_belt*pitch,
       radius_0 = num_teeth_0*pitch/(2*PI),
       radius_1 = num_teeth_1*pitch/(2*PI),
       guess = (num_teeth_0+num_teeth_1)/4*pitch,
       )
  assert(num_teeth_belt>=(num_teeth_0+num_teeth_1)/2,"Belt too short for given pulley tooth counts")
  exponentialSearchLength(radius_0,radius_1,belt_length,tol,guess);

function exponentialSearchLength(radius_0,radius_1,belt_length,tol,guess) =
  let (L = beltLength(radius_0,radius_1,guess))
  (L<belt_length) ? exponentialSearchLength(radius_0,radius_1,belt_length,tol,2*guess) : binarySearchLength(radius_0,radius_1,belt_length,tol,0,guess);

function binarySearchLength(radius_0,radius_1,Lb,tol,lower,upper) =
  let (mid = (lower+upper)/2,
       L = beltLength(radius_0,radius_1,mid)
       )
  ((upper-lower)<tol) ? mid : ((L>Lb) ? (binarySearchLength(radius_0,radius_1,Lb,tol,lower,mid)) : binarySearchLength(radius_0,radius_1,Lb,tol,mid,upper));


/* Computes total length of belt around two pulleys of given pitch
   circle radius and given center to center distance */
function beltLength(radius_0,radius_1,center_to_center) = let (beta=(PI/180)*asin((radius_0-radius_1)/center_to_center))
  // Straight Sections
  2*sqrt(center_to_center^2+(radius_0-radius_1)^2)
  // over and under wrap arcs 
  + 2*beta*radius_0 - 2*beta*radius_1
  + PI*radius_0 + PI*radius_1;       


st = abs($t-0.5);
t0 = floor(st*50)+10;
t1 = 70-t0;
/* linear_extrude(10) */
TwoPulleyBelt(t0,t1,80,st*100);

/* rotate((st*100/t1)*360+360/t0)linear_extrude(10)offset(r=-0.1)difference(){ */
/*   circle(d=2*t1/PI); */
/*   RoundGT2(t1,360); */
/* }; */
