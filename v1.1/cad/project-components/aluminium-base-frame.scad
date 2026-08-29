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

module rounded_box(size=[10,10,10], r=2) {
    x = size[0];
    y = size[1];
    z = size[2];
    rr = min(r, min(x,y)/2);

    translate([rr, rr, 0])
        linear_extrude(height=z)
            offset(r=rr)
                square([x-2*rr, y-2*rr]);
}

module wheel_tyre(center=[0,0,0]) {
    translate(center)
        color(wheel_color)
        rotate([90,0,0])
        difference() {
            cylinder(d=wheel_diameter, h=wheel_width, center=true);
            cylinder(d=wheel_diameter*0.46,
                     h=wheel_width+2*EPS, center=true);
        }

    translate(center)
        color(hub_color)
        rotate([90,0,0])
            cylinder(d=wheel_diameter*0.46,
                     h=wheel_width*0.72, center=true);

    translate(center)
        color(metal_color)
        rotate([90,0,0])
            cylinder(d=axle_diameter,
                     h=wheel_width+16, center=true);
}

module caster_mount_plate() {
    color(metal_color)
        translate([
            -caster_plate_x/2,
            -caster_plate_y/2,
            caster_overall_height-caster_plate_thickness
        ])
            rounded_box(
                [caster_plate_x, caster_plate_y, caster_plate_thickness],
                5
            );
}

module fixed_caster() {
    wheel_axle_z = wheel_diameter/2;
    fork_bottom = wheel_axle_z;
    fork_top = caster_overall_height-caster_plate_thickness;
    fork_h = fork_top-fork_bottom;
    fork_plate_t = 7;
    fork_gap = wheel_width + 8;

    caster_mount_plate();

    // Two side cheeks connect the wheel axle to the mounting plate.
    for (y=[
        -(fork_gap/2+fork_plate_t/2),
         (fork_gap/2+fork_plate_t/2)
    ])
        color(metal_color)
            translate([
                -fork_plate_t/2,
                y-fork_plate_t/2,
                fork_bottom
            ])
                cube([fork_plate_t, fork_plate_t, fork_h]);

    // Upper crosspiece directly below the mounting plate.
    color(metal_color)
        translate([
            -18,
            -(fork_gap+2*fork_plate_t)/2,
            fork_top-12
        ])
            cube([36, fork_gap+2*fork_plate_t, 12]);

    wheel_tyre([0,0,wheel_axle_z]);
}

module swivel_caster(mirror_y=false) {
    wheel_axle_z = wheel_diameter/2;
    pivot_z0 = caster_overall_height-caster_plate_thickness-22;
    wheel_offset_x = -caster_trail;
    fork_gap = wheel_width + 8;
    fork_plate_t = 7;

    caster_mount_plate();

    // Swivel bearing / kingpin.
    color(metal_color)
        translate([0,0,pivot_z0])
            cylinder(d=46, h=22);

    color(metal_color)
        translate([0,0,pivot_z0-10])
            cylinder(d=18, h=12);

    // Sloping spine from the swivel bearing to the wheel axle.
    color(metal_color)
        hull() {
            translate([0,0,pivot_z0])
                cylinder(d=18, h=8);

            translate([wheel_offset_x,0,wheel_axle_z+18])
                rotate([90,0,0])
                    cylinder(
                        d=16,
                        h=fork_gap+2*fork_plate_t,
                        center=true
                    );
        }

    // Two fork side plates.
    for (y=[
        -(fork_gap/2+fork_plate_t/2),
         (fork_gap/2+fork_plate_t/2)
    ])
        color(metal_color)
            hull() {
                translate([
                    wheel_offset_x-4,
                    y-fork_plate_t/2,
                    wheel_axle_z
                ])
                    cube([8, fork_plate_t, 42]);

                translate([
                    -4,
                    y-fork_plate_t/2,
                    pivot_z0-4
                ])
                    cube([8, fork_plate_t, 12]);
            }

    wheel_tyre([wheel_offset_x,0,wheel_axle_z]);
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
    // Same physical locations as the original centred model,
    // translated into the project coordinate system:
    // original +/-500 X -> 30 / 1030
    // original +/-305 Y -> 30 / 640.

    // Left side: fixed wheels.
    translate([profile_size/2, profile_size/2, 0])
        fixed_caster();

    translate([
        profile_size/2,
        frame_width-profile_size/2,
        0
    ])
        fixed_caster();

    // Right side: swivel wheels.
    translate([
        frame_length-profile_size/2,
        profile_size/2,
        0
    ])
        swivel_caster(false);

    translate([
        frame_length-profile_size/2,
        frame_width-profile_size/2,
        0
    ])
        swivel_caster(true);
}

module floor_reference() {
    color([0.85,0.85,0.85,0.20])
        translate([-50,-50,-1])
            cube([frame_length+100, frame_width+100, 1]);
}
