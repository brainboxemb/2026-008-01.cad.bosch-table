/*
50 mm caster-wheel reference.

The 50 mm wheel diameter is a photo-based working assumption and remains
parameterized in config.scad.
*/

// ------------------------------------------------------------
// Casters and Bosch reference model
// ------------------------------------------------------------

module caster_wheel() {
    // Mounting plate directly under the timber frame.
    color([0.55, 0.57, 0.58])
        translate([-caster_plate_x/2, -caster_plate_y/2,
                   caster_total_height - caster_plate_thickness])
            cube([caster_plate_x, caster_plate_y, caster_plate_thickness]);

    // Simple swivel fork / stem representation.
    color([0.48, 0.50, 0.52])
        translate([-7, -7, wheel_diameter/2 + 10])
            cube([14, 14,
                  caster_total_height - caster_plate_thickness
                  - (wheel_diameter/2 + 10)]);

    color([0.48, 0.50, 0.52])
        translate([0, 0, wheel_diameter/2 + 8])
            rotate([90, 0, 0])
                cylinder(h=wheel_width + 8, r=6, center=true);

    // Wheel axle runs in Y; wheel rolls in X/Z plane.
    color([0.08, 0.08, 0.08])
        translate([0, 0, wheel_diameter/2])
            rotate([90, 0, 0])
                cylinder(h=wheel_width, d=wheel_diameter, center=true);
}

module casters() {
    // Four 50 mm swivel casters. Positions are intentionally simple and
    // parametrised; they can be moved to the exact mounting locations later.
    for (x = [caster_inset_x, stand_length - caster_inset_x])
        for (y = [caster_inset_y, stand_depth - caster_inset_y])
            translate([x, y, 0])
                caster_wheel();
}

