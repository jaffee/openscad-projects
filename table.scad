
// ** Table Top ** //
// overall height
t_height = 30;
// width of long planks
plank_w = 9.25;
// number of long planks
num_planks = 5;
// length of long planks
plank_l = 95;
// total width of table
t_width = num_planks * plank_w;
// width of breadboard end 
bb_w = 11.25;
// total length of table
t_length = plank_l + bb_w*2;
echo("Total Length: ", t_length);
echo("Total Width:  ", t_width);
top_thickness = 1.5;
top_height = t_height - top_thickness;

// top layer
color("lightblue", 1){
     translate ([0, 0, top_height]) cube([t_width, bb_w, top_thickness]);
     translate ([0, t_length-bb_w, top_height]) cube([t_width, bb_w, top_thickness]);

     for(i = [0 : num_planks-1]) {
          translate([i * plank_w, bb_w, top_height]) cube([plank_w, plank_l, top_thickness]);
     }
}

l2_height = top_height - top_thickness;
l2_thck = 1.5;
l2_w = 3.5;
l2_end_l = t_width - (l2_w * 2);

echo("<b>TOP</b>");
echo("Top Layer:");
echo(str(num_planks, "x 2x", plank_w, " ", plank_l));
echo(str("2x 2x", bb_w, " ", t_width));
echo("Base Layer:");
echo(str("2x 2x4 ", t_length));
echo(str("2x 2x4 ", l2_end_l));

// second layer
color( "red", 1) {
     translate ([l2_w, 0, l2_height]) cube([l2_end_l, l2_w, l2_thck]);
     translate ([l2_w, t_length-l2_w, l2_height]) cube([l2_end_l, l2_w, l2_thck]);

     translate([0, 0, l2_height]) cube([l2_w, t_length, l2_thck]);
     translate([t_width - l2_w, 0, l2_height]) cube([l2_w, t_length, l2_thck]);
}

// legs
overhang_amnt = 4;
base_w = t_width - (overhang_amnt * 2);
end_overhang = 18;

bot_w = base_w;
top_w = l2_end_l;

board_thck = 1.5;
board_w = 5.5;

f5run = board_thck / tan(45); // horizontal dist of 45 degree cut in board_thck wood
post_w = 3.5;
post_dist = (top_w - (board_thck * 3)) / 2;
post_y_offset = (board_w - post_w)/2;
post_z_offset = board_thck*2;
post_height = (top_height - board_thck * 4);
midpost_height = (post_height - board_w) / 2;
echo("<b>LEGS</b>");
echo("Tops:");
echo(str("3x 2x6 ", top_w));
echo(str("3x 2x6 ", top_w-(f5run*2)));
echo("Posts:");
echo(str("6x 2x4 ", post_height));
echo(str("6x 2x4 ", midpost_height));
echo("Bottoms:");
echo(str("3x 2x6 ", bot_w));
echo(str("3x 2x6 ", bot_w- (f5run*2)));
echo("Curves:");
echo(str("12x 2x8 8"));


module curve_support() {
     difference() {
          cube([8, 1.5, 8]);
          translate([8, 1.501, 8]) rotate([90,0,0]) cylinder(h=1.502, r1=7, r2=7, center=false, $fn=100);
     }
}

module pedestal () {
     // assume top longer than bot

     width_diff = top_w - bot_w;
     offset = width_diff / 2;

     // bottom bits
     difference() {
          union () {
               translate([offset, 0, 0]) cube([bot_w, board_w, board_thck]);
               translate([offset+f5run, 0, board_thck]) cube([bot_w - (f5run*2), board_w, board_thck]);
          }
          translate([offset, -0.01, 0]) rotate([0, -45, 0]) cube([10, board_w+.02, board_thck]);
          translate([offset+bot_w, -0.01, 0]) rotate([0, 45, 0]) translate([-10,0,0]) cube([10, board_w+.02, board_thck]);
     }

     // post
     translate([post_dist, post_y_offset, post_z_offset]) cube([board_thck, post_w, post_height]);
     translate([post_dist + board_thck, post_y_offset, post_z_offset]) cube([board_thck, post_w, midpost_height]);
     translate([post_dist + board_thck, post_y_offset, post_z_offset + midpost_height + board_w]) cube([board_thck, post_w, midpost_height]);
     translate([post_dist + (board_thck*2), post_y_offset, post_z_offset]) cube([board_thck, post_w, post_height]);

     // curvey junk
     translate([post_dist + board_thck * 3, post_y_offset + (post_w - board_thck)/2, post_z_offset]) curve_support();
     translate([post_dist, post_y_offset + (post_w - board_thck)/2 + board_thck, post_z_offset]) rotate([0,0,180])  curve_support();

     translate([post_dist + board_thck * 3, post_y_offset + (post_w - board_thck)/2 + board_thck, post_height + (board_thck * 2)]) rotate([180,0,0]) curve_support();
     translate([post_dist, post_y_offset + (post_w - board_thck)/2, post_height + (board_thck * 2)]) rotate([180,0,180])  curve_support();

     // top bits
     translate([0, 0, top_height-board_thck]) cube([top_w, board_w, board_thck]);

     difference() {
          translate([f5run, 0, top_height-(board_thck*2)]) cube([top_w-(f5run*2), board_w, board_thck]);
          translate([f5run*2, -.01, top_height-(board_thck*2)]) rotate([0,-135,0])  cube([10, board_w+.02, board_thck]);
          translate([top_w-f5run, -.01, top_height-(board_thck)]) rotate([0,135,0])  cube([10, board_w+.02, board_thck]);
     }
}

color("green", 1) {
     translate([l2_w, end_overhang, 0]) pedestal();
     translate([l2_w, t_length-end_overhang-5.5, 0]) pedestal();
     translate([l2_w, (t_length-5.5)/2, 0]) pedestal();
}

echo("dist between posts: ", t_length-end_overhang-5.5-((t_length-5.5)/2+5.5));

color("purple", 1) {
     translate([(t_width-1.5)/2, end_overhang, post_z_offset+midpost_height]) cube([board_thck, t_length - (end_overhang*2), 5.5]);
}

echo("Beam:");
echo(str("1x 2x6 ", t_length - (end_overhang*2)));
