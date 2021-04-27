// foundation
foundation_z = 4;
depth = 15;
bdepth = 6; // depth of bumpout
rail_width = 0.5;
difference() {
  cube([19, depth, foundation_z]);
  
  // corner cutout
  translate([3, 0, -0.1]){ rotate([0, 0, 135]) { cube([10, 10, foundation_z+0.2]); }}
}

// extra bit
color([0.0, 0.9, 0.0]) {
  translate([-6, 3, 0]) cube([6, 18, 4]);
}

door_w = 32/12;
// door is centered 
door_x = (19-door_w)/2;

// wall (far)
color ("cyan") {translate([0, depth-0.4, 4]) {cube([door_x, 0.4, 2]);}}
color ("cyan") {translate([door_x+door_w, depth-0.4, 4]) {cube([door_x, 0.4, 2]);}}

// wall (left)
color ("cyan") {translate([0, 3, foundation_z]) {cube([0.4, depth-3, 2]);}}

// wall (right)
color ("cyan") {translate([19-0.4, 0, foundation_z]) {cube([0.4, depth, 2]);}}

// fireplace
color("red") {translate([7.75, 0, 4]) { cube([6, 2.5, 4]); }}

// bumpout
color("green") { translate([0, depth, 0]) { cube([19,bdepth,foundation_z]); }}

// rails
color("red") {
  // left
  translate([rail_width-6, 3, foundation_z]) rotate(90) rail(18);
  // back left
  translate([rail_width-6, depth+bdepth-rail_width, foundation_z]) rail(13.5-rail_width);
  // back right
  translate([7.5+4, depth+bdepth-rail_width, foundation_z]) rail(19-7.5-4);
  //right
  translate([19, depth, foundation_z]) rotate(90) rail(bdepth);
}
//color("grey") translate([-6, 3, foundation_z+3.5]) cube([1, 18, 0.15]);
//color("grey") translate([-6, 21-1, foundation_z+3.5]) cube([7.5+6, 1, 0.15]);

// counters
color("orange") {
  translate([door_x+door_w, depth, foundation_z]) cube([3, 1, 3.2]);
  translate([door_x+door_w+5.1, depth, foundation_z]) cube([2.6, 1, 3.2]);
}

// ooni station
  translate([door_x+door_w+0.66, depth+bdepth-3.4, foundation_z]) ooni();

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

// front left wall
translate([0.01, 15-3.51/12, foundation_z]) frame(door_x, 8);
// front right wall
translate([door_x+door_w, 15-3.51/12, foundation_z]) frame(19-door_x-door_w, 8);
// left wall
translate([0.01, 3, foundation_z]) frame90(12, 8);
translate([19-(3.51/12), 0, foundation_z]) frame90(15, 8);

translate([-3.5/12, 3, foundation_z+8]) rotate([0, 45, 0]) frame90(15, 13.9);
translate([19, 3, foundation_z+8]) rotate([0, -45, 0]) frame90(15, 13.4);

module rail(length) {

  difference() {
    cube([length, rail_width, 3.5]);
    translate([0.2, -0.1, 0.2]) cube([length-0.4, rail_width+0.2, 3.1]);
  }
  for(j=[0.5:0.5:length]) {
     translate([j, 0.17, 0.1]) cube([0.05, 0.05, 3.39]);
  }
}

module frame(width, height) {
color("brown") {
  difference() {
    cube([width, 3.5/12, height]);
    translate([1.5/12, -0.1, 1.5/12]) { cube([width-(3/12), 6/12, height-(3/12)]);}
  }
  for(j=[16/12:16/12:width-0.1]) {
    translate([j, 0, 0]) cube([0.5/12, 1.5/12, height]);
  }

}
}

module frame90(width, height) {
  translate([3.5/12, 0, 0])  rotate(90) frame(width, height);
}



// akorn
translate([15.1,18.1,4]) { akorn(); }

// table
translate([6.2, 6, 4]) { rotate(90) {table();} }

// stairs
//translate([0, 15,0]) rotate(90) stairs();

// stairs
//translate([0, 20,0]) rotate(0) stairs();
// stairs
translate([7.5, depth+bdepth,0]) rotate(0) stairs();

module stairs() {
  rise = 6.5/12;
  run = 10.25/12;
  for(j=[1:foundation_z/rise]) {
      color("blue") translate([0, (j-1)*run, foundation_z-(j*rise)]) {cube([4, run, rise]);}{}
  }
}

translate([18.5,4,4]) rotate(90) couch();

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

//the duplo itself
// parameters are: 
// width: 1 =standard 4x4 duplo with.
// length: 1= standard 4x4 duplo length
// height: 1= minimal duplo height
 
//slantcube(1, 2, 1);
//duplo(1,2,1);
angle = 8.53;

module slantcube(width,length,minheight)
{
    maxheight = minheight + tan(angle)*width;
    
    difference() {
//        color("green") {
                cube([width, length, maxheight]);
//        }

        translate([0, -0.1, minheight]) {
            rotate([0, -1*angle, 0]) {
                cube([width*2,length+0.2,maxheight]);
            }
        }

    }

}

module duplo(width,length,height) 
{
	//size definitions
	
	ns = 8.4;  //nibble start offset
	no = 6.53; //nibbleoffset
	nbo = 16; // nibble bottom offset
	
	duplowidth = 31.66;
	duplolength=31.66;
	duploheight=9.6;
	duplowall = 1.55;

    
    xtraheight = tan(angle)*width*duplowidth;
	
	//the cube
	difference() {
		slantcube(width*duplowidth,length*duplolength,height*duploheight);
		translate([duplowall,duplowall,-duplowall]) 	
			slantcube(width*duplowidth - 2*duplowall,length*duplolength-2*duplowall,height*duploheight);
	}


	//nibbles on top
	for(j=[1:length]) {
    ybase = (j-1) * duplolength;
		for (i = [1:width]) {
      xbase = (i-1) * duplowidth;
      zoff = tan(angle)*(xbase+ns);
      zoff2 =tan(angle)*(xbase+2*ns+no);
      translate([width*duplowidth/2,0,height*duploheight+tan(angle)*width*duplowidth/2]) {
      rotate([0,-angle,0]){
      translate([-width*duplowidth/2,0,0]) {
			  translate([xbase+ns,ybase+ns,2.25]) duplonibble();
   			translate([xbase+2*ns+no,ybase+2*ns+no,2.25]) duplonibble();
			  translate([xbase+2*ns+no,ybase+ns,2.25]) duplonibble();
			  translate([xbase+ns,ybase+2*ns+no,2.25]) duplonibble();
      }
      }
      }
		}
	}
  maxheight = tan(angle)*duplowidth*width + height*duploheight;

	//nibble bottom
  difference() {
    union() {
    	for(j=[1:length*2-1]) {
        ybase = j*(duplolength/2); 
     	  for (i = [1:width*2-1]) {
          xbase = i*(duplowidth/2);
          translate([xbase, ybase, 0]) duplobottomnibble(maxheight-0.1);
        }
	    }
    }
    translate([-0.1,-0.1,height*duploheight])
    rotate([0,-angle,0]){
     cube([0.2+width*duplowidth/cos(angle),length*duplolength+0.2,maxheight]);
     }
  }

	//little walls inside
	difference() {
		union() {
			for(j=[1:length]) {
				for (i = [1:width]) {
					translate([0,j*ns+(j-1)*(no),0 ]) cube([width*duplowidth,1.35,maxheight]);
					translate([0,(length*duplolength-(j*ns))-((j-1)*(no)),0 ]) cube([width*duplowidth,1.35,maxheight]);
					translate([i*ns+(i-1)*no,0,0 ]) cube([1.35,length*duplolength,maxheight]);
					translate([width*duplowidth-((i*ns)+(i-1)*no),0,0 ]) cube([1.35,length*duplolength,maxheight]);
				}
			}
		}
    union(){
        // hollow out the middle
    		translate([2*duplowall, 2*duplowall, -0.1]) {
            cube([width*duplowidth - 4*duplowall,length*duplolength-4*duplowall,maxheight]);
        }

        // chop off the top at an angle
        translate([0,-0.1,height*duploheight]) {
          rotate([0,-angle,0]){
            cube([0.2+width*duplowidth/cos(angle),length*duplolength+0.2,maxheight]);
          }
        }
    }
	}
}


module duplonibble() {
	  difference() {
		  cylinder(r=4.7,h=4.5,center=true,$fs = 0.01);
		  cylinder(r=3.4,h=5.5,center=true,$fs = 0.01);
	  }
}

module duplobottomnibble(height) {
	difference() {
		cylinder(r=6.6,h=height,$fs = 0.01);
		translate([0,0,-0.1])cylinder(r=5.3,h=height+1,$fs = 0.01);
	}
}

