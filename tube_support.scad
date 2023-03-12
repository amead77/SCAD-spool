/*
Creates a bearing support for a tube to fit in

think broom handle with a cap on the ends which a bearing attaches to
*/


//keep as 1
run = 1;
//keep as 128 unless you need more or less refinement
$fn = 128;
//overall length minus bearing & washer
c_length = 24;
c_width_external = 32;

//how big the thing you insert will be (required cutout)
c_width_internal = 25.5;
c_length_internal = 20;

//diameter of bearing shaft
c_bearing_hole = 11.9;
//length of shaft (thickness of bearing)
c_bearing_length = 11.5;

//how big an external lip for the tube
c_tube_edge = true;
c_tube_edge_width = 60;
c_tube_edge_length = 5;

//print a washer to prevent outer bearing touching 
c_bearing_washer = true;
c_bearing_washer_width = 20.5;
c_bearing_washer_thickness = 2;

//do you want screw holes to secure the tube
c_screw_holes = true;
c_screw_size = 4;


module create_tube() {
    cylinder(h = c_length, r = c_width_external / 2);
}


module create_bearing_supp() {
    if (c_bearing_washer == true) {
        cylinder(h = (c_length + c_bearing_length + c_bearing_washer_thickness), r = c_bearing_hole / 2);
    } else {
        cylinder(h = (c_length + c_bearing_length), r = c_bearing_hole / 2);
    }
}

module create_washer() {
    translate([0,0, c_length]) {
        cylinder(h = c_bearing_washer_thickness, r = c_bearing_washer_width / 2);
    }
}


module create_tube_edges() {
    cylinder(h = c_tube_edge_length, r = c_tube_edge_width / 2);
}

module remove_internal() {
    translate([0,0,-1]) 
        cylinder(h = c_length_internal + 1, r = c_width_internal / 2);
}


module remove_screw_holes() {
    translate([0,100, (c_length / 2) + c_bearing_washer_thickness]) {
        rotate([90,0,0])
            cylinder(h=200, r=c_screw_size / 2);
    }
}

if (run == 1) {
    difference() {
        union() {
            create_tube();
            create_bearing_supp();
            if (c_tube_edge == true) {
                create_tube_edges();
            }
            if (c_bearing_washer == true) {
                create_washer();
            }
        }
        remove_internal();
        if (c_screw_holes == true) {
            remove_screw_holes();
        }
    }
}