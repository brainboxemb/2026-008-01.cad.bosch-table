/*
60-series aluminium mobile base for Bosch GTS 10 XC table stand v1.1.

Outer size:
  1060 x 670 mm

Construction:
- front and rear transverse profiles span the full 670 mm width;
- the two longitudinal profiles are enclosed by them;
- with 60 mm profiles, each longitudinal member is therefore 940 mm long.

This is the fixed starting point for the custom v1.1 design.
*/

// ------------------------------
// Helpers
// ------------------------------
module rounded_box(size=[10,10,10], r=2) {
    // Hull-based box, sufficient for caster plates and brackets.
    sx = size[0]; sy = size[1]; sz = size[2];
    hull() {
        for (x=[r, sx-r], y=[r, sy-r])
            translate([x,y,0]) cylinder(r=r, h=sz);
    }
}

// Simplified 60-series extrusion. The body has four straight visual slots.
module extrusion_x(length, size=60, slot_w=10, slot_d=8, slots=true) {
    color(aluminium_color)
    difference() {
        translate([-length/2, -size/2, 0])
            cube([length, size, size]);

        if (slots) {
            // top and bottom slots
            translate([-length/2-EPS, -slot_w/2, size-slot_d])
                cube([length+2*EPS, slot_w, slot_d+EPS]);
            translate([-length/2-EPS, -slot_w/2, -EPS])
                cube([length+2*EPS, slot_w, slot_d+EPS]);

            // side slots
            translate([-length/2-EPS, -size/2-EPS, (size-slot_w)/2])
                cube([length+2*EPS, slot_d+EPS, slot_w]);
            translate([-length/2-EPS, size/2-slot_d, (size-slot_w)/2])
                cube([length+2*EPS, slot_d+EPS, slot_w]);
        }
    }
}

module extrusion_y(length, size=60, slot_w=10, slot_d=8, slots=true) {
    rotate([0,0,90])
        extrusion_x(length, size, slot_w, slot_d, slots);
}

module wheel_tyre(center=[0,0,0]) {
    translate(center)
    color(wheel_color)
    rotate([90,0,0])
    difference() {
        cylinder(d=wheel_diameter, h=wheel_width, center=true);
        cylinder(d=wheel_diameter*0.46, h=wheel_width+2*EPS, center=true);
    }

    translate(center)
    color(hub_color)
    rotate([90,0,0])
        cylinder(d=wheel_diameter*0.46, h=wheel_width*0.72, center=true);

    translate(center)
    color(metal_color)
    rotate([90,0,0])
        cylinder(d=axle_diameter, h=wheel_width+16, center=true);
}

module caster_mount_plate() {
    color(metal_color)
    translate([-caster_plate_x/2, -caster_plate_y/2,
               caster_overall_height-caster_plate_thickness])
        rounded_box([caster_plate_x, caster_plate_y, caster_plate_thickness], 5);
}

module fixed_caster() {
    wheel_axle_z = wheel_diameter/2;
    fork_bottom = wheel_axle_z;
    fork_top = caster_overall_height-caster_plate_thickness;
    fork_h = fork_top-fork_bottom;
    fork_plate_t = 7;
    fork_gap = wheel_width + 8;

    caster_mount_plate();

    // Two side cheeks around the wheel.
    for (y=[-(fork_gap/2+fork_plate_t/2), (fork_gap/2+fork_plate_t/2)])
        color(metal_color)
        translate([-fork_plate_t/2, y-fork_plate_t/2, fork_bottom])
            cube([fork_plate_t, fork_plate_t, fork_h]);

    // Upper crosspiece.
    color(metal_color)
    translate([-18, -(fork_gap+2*fork_plate_t)/2, fork_top-12])
        cube([36, fork_gap+2*fork_plate_t, 12]);

    wheel_tyre([0,0,wheel_axle_z]);
}

module swivel_caster(mirror_y=false) {
    wheel_axle_z = wheel_diameter/2;
    pivot_z0 = caster_overall_height-caster_plate_thickness-22;
    wheel_offset_x = -caster_trail;
    fork_gap = wheel_width + 8;
    fork_plate_t = 7;
    ysign = mirror_y ? -1 : 1;

    caster_mount_plate();

    // Swivel bearing / kingpin.
    color(metal_color)
    translate([0,0,pivot_z0])
        cylinder(d=46, h=22);
    color(metal_color)
    translate([0,0,pivot_z0-10])
        cylinder(d=18, h=12);

    // Sloping fork spine toward the wheel axle.
    color(metal_color)
    hull() {
        translate([0,0,pivot_z0])
            cylinder(d=18, h=8);
        translate([wheel_offset_x,0,wheel_axle_z+18])
            rotate([90,0,0])
                cylinder(d=16, h=fork_gap+2*fork_plate_t, center=true);
    }

    // Fork side plates.
    for (y=[-(fork_gap/2+fork_plate_t/2), (fork_gap/2+fork_plate_t/2)])
        color(metal_color)
        hull() {
            translate([wheel_offset_x-4, y-fork_plate_t/2, wheel_axle_z])
                cube([8, fork_plate_t, 42]);
            translate([-4, y-fork_plate_t/2, pivot_z0-4])
                cube([8, fork_plate_t, 12]);
        }

    wheel_tyre([wheel_offset_x,0,wheel_axle_z]);
}


// ------------------------------
// Assemblies
// ------------------------------
module aluminium_base_frame() {
    // The two long side rails are enclosed by the front/rear rails.
    // Their length is therefore the outer frame length minus two profile widths.
    for (y=[-side_rail_y, side_rail_y])
        translate([0,y,frame_z])
            extrusion_x(long_rail_length, profile_size,
                        profile_slot_width, profile_slot_depth,
                        show_profile_slots);

    // Front/rear rails span the full outer frame width.
    for (x=[-end_rail_x, end_rail_x])
        translate([x,0,frame_z])
            extrusion_y(frame_width, profile_size,
                        profile_slot_width, profile_slot_depth,
                        show_profile_slots);
}

module wheel_set() {
    // Rear (-X): fixed wheels.
    for (y=[-wheel_y, wheel_y])
        translate([-wheel_x,y,0])
            fixed_caster();

    // Front (+X): swivel wheels.
    for (y=[-wheel_y, wheel_y])
        translate([wheel_x,y,0])
            swivel_caster(y < 0);
}

module floor_reference() {
    color([0.82,0.82,0.82,0.22])
    translate([-frame_length/2-100,-frame_width/2-100,-2])
        cube([frame_length+200,frame_width+200,2]);
}

module assembly() {
    if (show_floor) floor_reference();
    aluminium_base_frame();
    wheel_set();
}

