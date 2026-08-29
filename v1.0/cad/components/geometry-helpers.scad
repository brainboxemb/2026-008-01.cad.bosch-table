/* Generic geometry helpers. */

// ------------------------------------------------------------
// Basic helpers
// ------------------------------------------------------------

// These rounded-prism helpers round ONLY the four edges parallel to the
// member length.  Cylinder caps make both end faces flat and square.  Any
// half-lap recess is subtracted afterwards, so the freshly sawn joint edges
// stay sharp as well.
module rounded_prism_x(length, width, height, radius) {
    r = min(radius, min(width, height) / 2 - 0.01);
    if (r <= 0) {
        cube([length, width, height]);
    } else {
        hull()
            for (yy = [r, width-r])
                for (zz = [r, height-r])
                    translate([0, yy, zz])
                        rotate([0, 90, 0])
                            cylinder(h=length, r=r);
    }
}

module rounded_prism_y(length, width, height, radius) {
    r = min(radius, min(width, height) / 2 - 0.01);
    if (r <= 0) {
        cube([width, length, height]);
    } else {
        hull()
            for (xx = [r, width-r])
                for (zz = [r, height-r])
                    translate([xx, 0, zz])
                        rotate([-90, 0, 0])
                            cylinder(h=length, r=r);
    }
}

module rounded_prism_z(length, width_x, width_y, radius) {
    r = min(radius, min(width_x, width_y) / 2 - 0.01);
    if (r <= 0) {
        cube([width_x, width_y, length]);
    } else {
        hull()
            for (xx = [r, width_x-r])
                for (yy = [r, width_y-r])
                    translate([xx, yy, 0])
                        cylinder(h=length, r=r);
    }
}

module sheet_xz(width, height, thickness, x, y, z, c) {
    color(c)
        translate([x, y, z])
            cube([width, thickness, height]);
}

module sheet_yz(depth, height, thickness, x, y, z, c) {
    color(c)
        translate([x, y, z])
            cube([thickness, depth, height]);
}

module sheet_xy(width, depth, thickness, x, y, z, c) {
    color(c)
        translate([x, y, z])
            cube([width, depth, thickness]);
}

