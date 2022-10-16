$fs=0.01;
$fa=0.01;

module B6809(center=true,clearance=0){
  bearing(id=45,od=58,w=7,center=center,clearance=clearance);
  };

module B688(center=true,clearance=0){
  bearing(id=8,od=16,w=5,center=center,clearance=clearance);
  };

module B695(center=true,clearance=0){
  bearing(id=5,od=13,w=4,center=center,clearance=clearance);
  };

module B683(center=true,clearance=0){
  bearing(id=3,od=7,w=3,center=center,clearance=clearance);
  };
module B684(center=true,clearance=0){
  bearing(id=4,od=9,w=4,center=center,clearance=clearance);
  };
module B685(center=true,clearance=0){
  bearing(id=5,od=11,w=5,center=center,clearance=clearance);
  };

module B95(center=true,clearance=0){
  bearing(id=5,od=9,w=2.5,center=center,clearance=clearance);
  };
module B105(center=true,clearance=0){
  bearing(id=5,od=10,w=3,center=center,clearance=clearance);
  };
module B115(center=true,clearance=0){
  bearing(id=5,od=11,w=3,center=center,clearance=clearance);
  };


module bearing(id,od,w,clearance=0,center=true){
  color("silver")linear_extrude(w+clearance*2,center=center)
  difference(){
    circle(d=od+clearance*2);
    circle(d=id-clearance*2);
  };
};
