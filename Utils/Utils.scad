module round(a,b,chamfer=false){
  offset(a,chamfer=true)offset(-b-a)offset(b) children();
    };
module chamfer(a,b,chamfer=false){
  offset(delta=a,chamfer=true)offset(-b-a)offset(b) children();
    };
