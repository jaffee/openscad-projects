// foundation
bay_width = 6;
foundation_z = 40/12;
depth = 15;
bdepth = 6; // depth of bumpout
rail_width = 0.4;
difference() {
  color("grey") translate([-bay_width-3,0,0]) cube([19+6+3, depth, foundation_z]);
  translate([-9.1, 15-(run*6),-0.1])  cube([4.1,run*6+1,foundation_z+1]);
  
}


// fireplace
color("brown") {translate([7.75, 0, foundation_z]) { cube([6, 2.5, 6]); }}


// house

color("sienna") {
  translate([-20,-2,0]) {
    cube([40, 2, 15]);
  }
}

// bay window
color("sienna") {
difference() {
  translate([0-bay_width-3,0,0]) {
    color("gainsboro") cube([bay_width+6,3,15]);
  }
  translate([3,0,-0.1]) rotate([0,0,45]) color("gainsboro") cube([10,10,15+0.2]);
  translate([-bay_width-3,0,-0.1]) rotate([0,0,45]) color("gainsboro") cube([10,10,15+0.2]);
}
}

difference() {
//stairs();
//translate([-20,0,-1]) cube([20, 20, 1]);
}


rbase = 1;

module circlestairs() {
  rise = 7/12;
  run = 10.5/12;
  for(j=[1:6]) {
    cylinder(h=0.01+foundation_z-((j-1)*rise), r1=rbase+j*run, r2=rbase+j*run, $fn=360);
  }
}

offset = 4.8;
// color("grey") translate([-6+offset, 15-offset, 0]) circlestairs();


railheight = 3;

module railing(length) {
  spacing=0.5;
  color("black") {
    translate([0,-0.2,railheight]) cube([length, 0.4, 1.5/12]);
    for(j=[0.5:spacing:length]) {
      translate([j-(spacing/2), 0, 0]) cylinder(h=railheight, r1=0.05, r2=0.05, $fn=60);
    }
  }
};

translate([-8.75, 0, foundation_z]) rotate([0,0,90]) railing(10);
translate([-5, 15, foundation_z]) rotate([0,0,0]) railing(23);
translate([-4.75, 15-(run*6), foundation_z]) rotate([0,0,90]) railing(run*6);


rise = 7/12;
run = 10.5/12;

module straightsteps() {
  num = 6;
  for(j=[1:num])  {
    h=foundation_z-(j*rise);
    color("grey") translate([0, 0, h]) cube([run*j, 4, rise]);
    color("black") translate([(run/2)+(run*(j-1)), 3.75, h+rise]) cylinder(h=railheight, r1=0.05, r2=0.05, $fn=60);
    color("black") translate([(run/2)+(run*(j-1)), 0.25, h+rise]) cylinder(h=railheight, r1=0.05, r2=0.05, $fn=60);
  }
  color("black") translate([0, 3.5, foundation_z+3+0.15]) rotate([0, atan(rise/run), 0]) cube([sqrt((run*6)^2+(rise*6)^2), 0.4, 1.5/12]);
  color("black") translate([0, 0, foundation_z+3+0.15]) rotate([0, atan(rise/run), 0]) cube([sqrt((run*6)^2+(rise*6)^2), 0.4, 1.5/12]);
}

translate([-5, 15-(run*6), 0]) rotate([0,0,90]) straightsteps();
//translate([0, 0, 20]) straightsteps();

// akorn
// translate([15.1,18.1,4]) { akorn(); }

module stairs() {
  rise = 7/12;
  run = 10.5/12;
  for(j=[1:5]) {
      color("grey") translate([-6-run*j, 0, foundation_z-(j*rise)-rise]) cube([10, 7+(j-1)*run, rise]);
  }
}

// translate([18.5,4,4]) rotate(90) couch();

module couch() {
  color("pink") {
    // base
    cube([6, 3, 1.5]);
    // back
    cube([6, 0.3, 2.5]);
    // arm
    cube([0.3, 3, 2]);
    translate([6-0.3,0,0])cube([0.3, 3, 2]);
  }

}


module chair() {
  chair_w = 1.5;
  chair_d = 1.5;
  chair_h = 1.5;
  color("violet") {
    translate([0, 0, chair_h]) cube([chair_w, chair_d, 0.2]);
    translate([0, 0, chair_h]) cube([chair_w, 0.2, 2]);

    translate([0, 0, 0]) cube([0.2, 0.2, chair_h]);
    translate([chair_w-0.2, 0, 0]) cube([0.2, 0.2, chair_h]);
    translate([chair_w-0.2, chair_d-0.2, 0]) cube([0.2, 0.2, chair_h]);
    translate([0, chair_d-0.2, 0]) cube([0.2, 0.2, chair_h]);
  }  
       
}


module akorn()
{
  color("black") {
    translate([.75, 0, 0]) { cube([2.4, 2.4, 4]); }
    translate([0, .75, 3]) { cube([0.75, 1, 0.2]);}
    translate([2.4+.75, .75, 3]) { cube([0.75, 1, 0.2]);}
  }
}

module table() {
  width = 3.5;
  length = 8;
  height = 2.8;
  color("purple") {
    translate([0, 0, height]) { cube([length, width, 0.2]); }
    // legs
    translate([0, 0, 0]) { cube([0.2, 0.2, height]); }
    translate([length-0.2, 0, 0]) { cube([0.2, 0.2, height]); }
    translate([length-0.2, width-0.2, 0]) { cube([0.2, 0.2, height]); }
    translate([0, width-0.2, 0]) { cube([0.2, 0.2, height]); }
  }

  for(j=[0:2:length-1]) {
    translate([(j/2)*2+0.25, -2, 0]) chair();
  }
  for(j=[0:2:length-1]) {
    translate([(j/2)*2+0.25+1.5, 2+width, 0]) rotate(180) chair();
  }
}

angle = 8.53;

module ooni() {
  ooni_h = 3;
  ooni_d = 3;
  ooni_w = 3.5;
  color("indigo") {
    translate([0,0,ooni_h]) cube([ooni_w, ooni_d, 0.2]);
    translate([0,0,0]) cube([0.2,0.2,ooni_h]);
    translate([ooni_w-0.2,0,0]) cube([0.2,0.2,ooni_h]);
    translate([ooni_w-0.2,ooni_d-0.2,0]) cube([0.2,0.2,ooni_h]);
    translate([0,ooni_d-0.2,0]) cube([0.2,0.2,ooni_h]);
  }
}

