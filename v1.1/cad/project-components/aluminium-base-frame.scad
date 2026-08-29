/*
60-series aluminium mobile base for Bosch GTS 10 XC table stand v1.1.

Coordinate convention:
  X = left -> right
  Y = front -> rear
  Z = floor -> up

The project origin is the front-left floor point: [0,0,0].

Outer frame size:
  1060 x 670 mm

Construction:
- front and rear transverse profiles span the full 670 mm depth;
- the two longitudinal profiles fit between the transverse profiles;
- with 60 mm profiles, each longitudinal member is 940 mm long.
*/

module profile_60(length, axis="x") {
    // Lightweight visual representation of a 60 x 60 aluminium extrusion.
    color(aluminium_color)
    difference() {
        if (axis == "x")
            cube([length, profile_size, profile_size]);
        else if (axis == "y")
            cube([profile_size, length, profile_size]);

        if (show_profile_slots) {
            if (axis == "x") {
                // top slot
                translate([-EPS, (profile_size-profile_slot_width)/2,
                           profile_size-profile_slot_depth])
                    cube([length+2*EPS, profile_slot_width,
                          profile_slot_depth+EPS]);

                // outer side slot
                translate([-EPS, profile_size-profile_slot_depth,
                           (profile_size-profile_slot_width)/2])
                    cube([length+2*EPS, profile_slot_depth+EPS,
                          profile_slot_width]);
            } else {
                // top slot
                translate([(profile_size-profile_slot_width)/2, -EPS,
                           profile_size-profile_slot_depth])
                    cube([profile_slot_width, length+2*EPS,
                          profile_slot_depth+EPS]);

                // outer side slot
                translate([profile_size-profile_slot_depth, -EPS,
                           (profile_size-profile_slot_width)/2])
                    cube([profile_slot_depth+EPS, length+2*EPS,
                          profile_slot_width]);
            }
        }
    }
}

module fixed_wheel() {
    color(metal_color)
        translate([-caster_plate_x/2, -caster_plate_y/2,
                   caster_overall_height-caster_plate_thickness])
            cube([caster_plate_x, caster_plate_y, caster_plate_thickness]);

    color(metal_color)
        translate([0, 0, wheel_diameter/2])
            rotate([90,0,0])
                cylinder(d=axle_diameter, h=wheel_width+12, center=true);

    color(wheel_color)
        translate([0, 0, wheel_diameter/2])
            rotate([90,0,0])
                cylinder(d=wheel_diameter, h=wheel_width, center=true);

    color(hub_color)
        translate([0, -(wheel_width/2+0.5), wheel_diameter/2])
            rotate([90,0,0])
                cylinder(d=axle_diameter*1.8, h=1, center=true);
}

module swivel_wheel() {
    color(metal_color)
        translate([-caster_plate_x/2, -caster_plate_y/2,
                   caster_overall_height-caster_plate_thickness])
            cube([caster_plate_x, caster_plate_y, caster_plate_thickness]);

    color(metal_color)
        translate([0, 0, caster_overall_height-caster_plate_thickness-18])
            cylinder(d=28, h=18);

    translate([caster_trail, 0, 0])
        fixed_wheel();
}

module aluminium_base_frame() {
    z = caster_overall_height;

    // Front and rear full-depth transverse profiles.
    translate([0, 0, z])
        profile_60(frame_width, "y");

    translate([frame_length-profile_size, 0, z])
        profile_60(frame_width, "y");

    // Longitudinal profiles are enclosed between the transverse profiles.
    translate([profile_size, 0, z])
        profile_60(long_rail_length, "x");

    translate([profile_size, frame_width-profile_size, z])
        profile_60(long_rail_length, "x");
}

module wheel_set() {
    // Front: swivel casters.
    translate([profile_size/2, profile_size/2, 0])
        swivel_wheel();

    translate([frame_length-profile_size/2, profile_size/2, 0])
        swivel_wheel();

    // Rear: fixed wheels.
    translate([profile_size/2, frame_width-profile_size/2, 0])
        fixed_wheel();

    translate([frame_length-profile_size/2,
               frame_width-profile_size/2, 0])
        fixed_wheel();
}

module floor_reference() {
    color([0.85,0.85,0.85,0.20])
        translate([-50,-50,-1])
            cube([frame_length+100, frame_width+100, 1]);
}
