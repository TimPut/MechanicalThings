use <../../Utils/ProperlySpacedBelts.scad>;
use <../../Utils/Utils.scad>;

module RolamiteGT2(n=66){
  };

RolamiteGT2();

function RolamiteBeltLength(d_center,d_idler) =
  3/4 * PI * d_center
  + 3 * (d_center * 0.5 * sqrt(2)) + (d_idler * 0.5 * sqrt(2)) +
  + (1+3/4) * PI * d_idler;

symmetric_rolamite_roller_from_belt = 1/RolamiteBeltLength(1,1);
echo(2*66*symmetric_rolamite_roller_from_belt);

/* nb. roller sizes are not real sizes but rather effective sizes measured at the pitch line that the roller imparts on the belt */