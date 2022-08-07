$fa=0.05;
$fn=100;

/* hyper(); */
/* linear_extrude(height = 10, center = true, convexity = 1, twist = 0, slices = 1, scale = 1.0) */
/* render() */
/* linear_extrude(height=3)difference(){ */
/* circle(d=50); */
/* projection()rotate([0,60,0])linear_extrude(height=0.0001)gear0(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch); */
/* } */

pressure_angle = 20;
m = 2;
teeth = 13;
thickness = 8;
lead = 10;

pitch = PI*m;
pitch_diameter = pitch * teeth / PI;
pitch_radius = pitch_diameter / 2;
side_depth = 2.00*sin(pressure_angle)*pitch;
minor_diameter = pitch_diameter - side_depth/2;
minor_pitch = minor_diameter * PI / teeth;
flats = (minor_pitch/2-tan(pressure_angle)*side_depth);
twst = tan(lead)*(180/(PI*pitch_radius))*thickness;
shift = (side_depth*-0)/2;

/* pressure_angle = 20; */
/* m = 2; */
/* pitch = PI*m; */
teeth1 = 58;
pitch_diameter1 = pitch * teeth1 / PI;
pitch_radius1 = pitch_diameter1 / 2;
/* side_depth = 2.00*sin(pressure_angle)*pitch; */
minor_diameter1 = pitch_diameter1 - side_depth/2;
minor_pitch1 = minor_diameter1 * PI / teeth1;
flats1 = (minor_pitch1/2-tan(pressure_angle)*side_depth);
thickness1 = 8;
lead1 = 10;
twst1 = tan(lead1)*(180/(PI*pitch_radius1))*thickness1;
/* shift = (side_depth*-0)/2; */


t=$t*360/teeth;
module InvoluteHalfTooth(pitch,pressure_angle,side_depth,flats){
    let (a = 0.5*tan(pressure_angle)*side_depth){
    polygon(points = [ [-a, 0],
                       [a,side_depth],
                       [a+flats,side_depth], // ugly
                       [a+flats,,-side_depth],
                       [-a-flats,-side_depth],
                       [-a-flats,0],
                       ]);
     /* translate([+pitch-a+flats,side_depth-tan(pressure_angle)*flats])circle(r=flats/cos(pressure_angle),$fn=50); */
        };
};

// constructs a wedge large enough to cut a single tooth from. the wedge is a
// triangular segment of the regular n-gon whose inscribed circle is the outer
// gear circle, where n is the number of teeth
//
// we use a circumscribing polygon and not circular because we're
// cutting the outer edge anyway, all those extra vertices would just be wasted
// computation.
module wedge(d,theta,n){
    let (circumscribed_diameter = d/cos(180/n),
         theta_2 = theta/2,
         // add $fa to avoid floating point error sized gap inbetween segments
         a = circumscribed_diameter*sin(theta_2+$fa)/2,
         b = -(circumscribed_diameter*cos(theta_2)/2)){
        polygon(points =
                [[a, b],
                 [-a, b],
                 [0,0]]);
    };
};

module half_inv(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch){
    let (
    ){
    rotate(90/teeth)
        difference(){
        wedge(d=pitch_diameter+side_depth,theta=180/teeth,n=teeth);
        union(){
        for (i = [-180/teeth:$fa:180/teeth]){
            rotate(2*i)
                translate([-pitch_diameter*PI*i/180,-pitch_diameter/2-side_depth/2-shift])
                InvoluteHalfTooth(pitch,pressure_angle,side_depth,flats);
        };

        rotate(0.5*360/teeth)mirror([1,0])for (i = [-180/teeth:$fa:180/teeth]){
            rotate(2*i)
                translate([-pitch_diameter*PI*i/180,-pitch_diameter/2-side_depth/2-shift])
                InvoluteHalfTooth(pitch,pressure_angle,side_depth,flats);

        };
        };
    };
    };
};
module inv(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch){
    half_inv(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch);
    mirror([1,0])half_inv(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch);
};

module gear0(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch){
    for (i = [0:teeth-1]){
        rotate(i*360/teeth)inv(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch);
    };
};
/* linear_extrude(height=thickness,twist=twst)gear(); */

module alt_gear(){
    for (i = [0:teeth-1]){
        rotate(i*360/teeth)alt_inv();
    };
};
module alt_inv(){
    half_inv();
    mirror([1,0])alt();
};

module alt(){
    rotate(90/teeth)
    intersection_for(i = [-90/teeth:$fa:90/teeth]){
        difference(){
        wedge(d=pitch_diameter+side_depth,theta=180/teeth,n=$fa);
        rotate(2*i)translate([-pitch_diameter*PI*i/180,-pitch_diameter/2-side_depth/2])InvoluteHalfTooth(pitch,pressure_angle,side_depth,flats);
        };
    };
};


module straight(){
linear_extrude(height=thickness)alt_gear();
rotate(-t)linear_extrude(height=thickness)gear0(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch);
color("teal")translate([pitch_diameter+2*shift,0,0])rotate(t-360/(2*teeth))linear_extrude(height=thickness)gear0(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch);
};
/* straight(); */

/* color("teal")translate([pitch_diameter+2*shift,0,0]) */
/* rotate(t-360/(2*teeth))linear_extrude(height=thickness) */




// Skew Hyperboloidal gears
module hyper(){
//twist is alpha
//axis tilt is theta
//d is axis offset (closest approach), this is an overall scaler because the twist really should be a twist rate
//r is pitch circle radius
//h is half height of the twist rate
function d(r,alpha) = 2*r*(1-cos(alpha));
/* function alpha(h,r,theta) = asin((h/r)*((1-cos(theta))/sin(theta))); */
function alpha(h,r,theta) = let (p = (h/r)*(sin(theta)/(1+cos(theta)))) asin(p%1)+90*(p-p%1);
/* (asin(p%1)+360*(p-p%1)); */
$t=0;
/* theta = $t*89+1; */
theta = 90;
hh = 50;
rr = (pitch_radius+pitch_radius1)/2;
alpha = alpha(hh,rr,theta);
slice = 0;
sliceD = 300;
/* echo(((hh/pitch_radius)*(sin(theta)/(1+cos(theta))))%1); */
echo(alpha);
dd = d(rr,alpha);
translate([0,0,0*hh])// center on default camera
rotate(60)// rotate for nice view
    /* cube([100,100,100],center=true); */
/* intersection(){ */
union(){
    intersection(){
        translate([0,0,slice])cube([1000,1000,sliceD],center=true);
    linear_extrude(height = hh*2, center = true, convexity = 10, twist = 2*alpha, slices = 1, scale = 1)
rotate(-360*$t)gear0(teeth,pitch_diameter,side_depth,shift,pressure_angle,flats,pitch);
    };

    color("teal")translate([-dd+rr*2+0*1.2,0,0])rotate([theta,0,0])rotate((0+(teeth/teeth1))*2*alpha+0*180/teeth)
    intersection(){
     translate([0,0,slice])cube([1000,1000,sliceD],center=true);
      linear_extrude(height = hh*2, center = true, convexity = 10, twist = 2*alpha, slices = 1, scale = 1.0)
          rotate(360*$t)gear0(teeth1,pitch_diameter1,side_depth,shift,pressure_angle,flats1,pitch);
    };

};
};
/* }; */
n = 24;
module primitive(){
    let (p = [for (d = [0:1:360/n]) rotate(d)[n*m,0]]){
        echo(p);
        polygon(p);
    }
};

primitive();
