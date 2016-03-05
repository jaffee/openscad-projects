
t_height = 30;
plank_w = 9.25;
num_planks = 5;
t_width = num_planks * plank_w;
end_w = 11.25;
end_l = t_width;
plank_l = 96;
t_length = plank_l + end_w*2;

echo("Total Length: ", t_length);
echo("Total Width:  ", t_width);
top_thickness = 1.5;
top_height = t_height - top_thickness;
l2_height = top_height - top_thickness;

l2_w = 3.5;
l2_end_l = end_l - (l2_w * 2);
l2_l = t_length;


translate ([0, 0, top_height]) cube([end_l, end_w, top_thickness]);
translate ([0, t_length-end_w, top_height]) cube([end_l, end_w, top_thickness]);

for(i = [0 : num_planks-1]) {
    translate([i * plank_w, end_w, top_height]) cube([plank_w, plank_l, top_thickness]);
}


// second layer
color( "red", 1) {
     translate ([l2_w, 0, l2_height]) cube([l2_end_l, l2_w, top_thickness]);
     translate ([l2_w, t_length-l2_w, l2_height]) cube([l2_end_l, l2_w, top_thickness]);

     translate([0, 0, l2_height]) cube([l2_w, l2_l, top_thickness]);
     translate([t_width - l2_w, 0, l2_height]) cube([l2_w, l2_l, top_thickness]);
}

// leg
overhang_amnt = 4;
base_w = t_width - (overhang_amnt * 2);
end_overhang = 18;

module pedestal (bot_w, top_w, height, board_w) {
     board_thck = 1.5;
     f5run = board_thck / tan(45); // horizontal dist of 45 degree cut in board_thck wood
     post_w = 3.5;
     echo("THEIGHT INSIDE: ", t_height);
     // assume top longer than bot
     width_diff = top_w - bot_w;
     echo("width_diff: ", width_diff);
     offset = width_diff / 2;

     // bottom bits
     translate([offset, 0, 0]) cube([bot_w, board_w, board_thck]);
     translate([offset+f5run, 0, board_thck]) cube([bot_w - (f5run*2), board_w, board_thck]);

     post_dist = (top_w - (board_thck * 3)) / 2;
     post_y_offset = (board_w - post_w)/2;
     post_z_offset = board_thck*2;
     post_height = (height - board_thck * 4);
     midpost_height = (post_height - board_w) / 2;

     // post
     translate([post_dist, post_y_offset, post_z_offset]) cube([board_thck, post_w, post_height]);
     translate([post_dist + board_thck, post_y_offset, post_z_offset]) cube([board_thck, post_w, midpost_height]);
     translate([post_dist + board_thck, post_y_offset, post_z_offset + midpost_height + board_w]) cube([board_thck, post_w, midpost_height]);
     translate([post_dist + (board_thck*2), post_y_offset, post_z_offset]) cube([board_thck, post_w, post_height]);

     // top bits
     translate([0, 0, height-board_thck]) cube([top_w, board_w, board_thck]);
     translate([f5run, 0, height-(board_thck*2)]) cube([top_w-(f5run*2), board_w, board_thck]);
}

color("green", 1) {
     board_w = 5.5;
     translate([l2_w, end_overhang, 0]) pedestal(base_w, l2_end_l, top_height, board_w);
     translate([l2_w, t_length-end_overhang-5.5, 0]) pedestal(base_w, l2_end_l, top_height, board_w);
     translate([l2_w, (t_length-5.5)/2, 0]) pedestal(base_w, l2_end_l, top_height, board_w);
}

color("purple", 1) {
     height = top_height;
     board_w = 5.5;
     board_thck = 1.5;
     post_z_offset = board_thck*2;
     post_height = (height - board_thck * 4);
     midpost_height = (post_height - board_w) / 2;
     translate([(t_width-1.5)/2, end_overhang-0.5, post_z_offset+midpost_height]) cube([board_thck, (t_length+1) - (end_overhang*2), 5.5]);
}


//
//module stud (length, rot) {
//    rotate(rot) cube([1.5, 3.5, length]);
//}
//
//// front uprights
//stud(height); // cube([1.5,3.5,height]);    
//translate([shelf_width + 1.5, 0]) stud(height);
//translate([frame_width, 0]) stud(height, [0,0,90]);
//
//// rear uprights
//translate([0, depth-3.5]) stud(height);
//translate([shelf_width + 1.5, depth-3.5]) stud(height);
//translate([frame_width, depth-1.5]) stud(height, [0,0,90]);
//
//
//
//// shelf flats
//translate([1.5, 0, floor_clearance+2]) stud(shelf_width, [0, 90, 0]); //cube([shelf_width, 3.5, 1.5]);
//translate([1.5, depth-3.5, floor_clearance+2]) cube([shelf_width, 3.5, 1.5]);
//
//translate([1.5, 0, mid_height]) cube([shelf_width, 3.5, 1.5]);
//translate([1.5, depth-3.5, mid_height]) cube([shelf_width, 3.5, 1.5]);
//
//translate([1.5, 0, height-1.5]) cube([shelf_width, 3.5, 1.5]);
//translate([1.5, depth-3.5, height-1.5]) cube([shelf_width, 3.5, 1.5]);
//
//
//// shelf depth supports
////   bottom
//translate([0, 3.5, floor_clearance]) cube([1.5, depth-7, 3.5]);
//translate([shelf_width+1.5, 3.5, floor_clearance]) cube([1.5, depth-7, 3.5]);
//
////   middle
//translate([0, 3.5, mid_height-2]) cube([1.5, depth-7, 3.5]);
//translate([shelf_width+1.5, 3.5, mid_height-2]) cube([1.5, depth-7, 3.5]);
//
////   top
//translate([0, 3.5, height-3.5]) cube([1.5, depth-7, 3.5]);
//translate([shelf_width+1.5, 3.5, height-3.5]) cube([1.5, depth-7, 3.5]);
//
//// right side depth supports
//translate([frame_width-1.5, 1.5, floor_clearance]) cube([1.5, depth-3, 3.5]);
//translate([frame_width-1.5, 1.5, height-3.5]) cube([1.5, depth-3, 3.5]);
//
//
//// crossbeams
////   front bottom
//translate([shelf_width+3, 0, floor_clearance]) cube([main_width, 1.5, 3.5]); 
////   front top
//translate([shelf_width+3, 0, height-3.5]) cube([main_width, 1.5, 3.5]); 
////   back bottom
//translate([shelf_width+3, depth-1.5, floor_clearance]) cube([main_width, 1.5, 3.5]); 
////   back top
//translate([shelf_width+3, depth-1.5, height-3.5]) cube([main_width, 1.5, 3.5]); 
//