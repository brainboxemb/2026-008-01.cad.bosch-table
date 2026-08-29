/* Cabinet panels, drawers and worktop from the reference design. */

// ------------------------------------------------------------
// Cabinet panels around the drawer bay
// ------------------------------------------------------------
module cabinet_panels() {
    // 640 x 600 mm bottom panel in the drawer bay.
    sheet_xy(
        large_bottom_width,
        large_bottom_depth,
        osb_thickness,
        left_post_x + post_x,
        (stand_depth - large_bottom_depth) / 2,
        rail_height,
        osb_color
    );

    // Left and centre slide-support panels.
    sheet_yz(
        left_side_depth,
        left_side_height,
        osb_thickness,
        left_post_x + post_x,
        (stand_depth - left_side_depth) / 2,
        rail_height,
        osb_color
    );

    sheet_yz(
        center_side_depth,
        center_side_height,
        osb_thickness,
        center_post_x - osb_thickness,
        (stand_depth - center_side_depth) / 2,
        rail_height,
        osb_color
    );

    // Rear panel: 600 x 321 mm.
    sheet_xz(
        rear_panel_width,
        rear_panel_height,
        mpx_poplar_thickness,
        left_post_x + post_x,
        stand_depth - rail_depth - mpx_poplar_thickness,
        rail_height,
        poplar_color
    );
}

// ------------------------------------------------------------
// Drawer construction
// ------------------------------------------------------------
module standard_drawer(z, open_distance = 0) {
    x0 = left_post_x + post_x
       + (drawer_bay_clear_width - (drawer_body_width + 2*osb_thickness)) / 2;
    y0 = rail_depth - open_distance;

    sheet_xy(
        drawer_bottom_width,
        drawer_bottom_depth,
        osb_thickness,
        x0 + osb_thickness,
        y0,
        z,
        osb_color
    );

    for (x = [x0, x0 + osb_thickness + drawer_body_width])
        sheet_yz(
            drawer_body_depth,
            drawer_side_height,
            osb_thickness,
            x,
            y0,
            z,
            osb_color
        );

    for (y = [y0, y0 + drawer_body_depth - osb_thickness])
        sheet_xz(
            drawer_body_width,
            drawer_side_height,
            osb_thickness,
            x0 + osb_thickness,
            y,
            z,
            osb_color
        );
}

module low_dust_drawer(z, open_distance = 0) {
    outer_w = drawer_low_bottom_width + 2*osb_thickness;
    x0 = left_post_x + post_x + (drawer_bay_clear_width - outer_w) / 2;
    y0 = (stand_depth - drawer_low_bottom_depth) / 2 - open_distance;

    sheet_xy(
        drawer_low_bottom_width,
        drawer_low_bottom_depth,
        osb_thickness,
        x0 + osb_thickness,
        y0,
        z,
        osb_color
    );

    for (x = [x0, x0 + osb_thickness + drawer_low_bottom_width])
        sheet_yz(
            drawer_body_depth,
            drawer_low_side_height,
            osb_thickness,
            x,
            y0,
            z,
            osb_color
        );

    for (y = [y0, y0 + drawer_low_bottom_depth - osb_thickness])
        sheet_xz(
            drawer_low_bottom_width,
            drawer_low_side_height,
            osb_thickness,
            x0 + osb_thickness,
            y,
            z,
            osb_color
        );
}

module drawer_facade(z, h, open_distance = 0) {
    x = left_post_x + post_x
      + (drawer_bay_clear_width - drawer_front_width) / 2;
    y = drawer_front_inset_y - open_distance;

    color(drawer_front_color)
        translate([x, y, z])
            cube([drawer_front_width, drawer_front_thickness, h]);
}

module drawers() {
    standard_drawer(bottom_drawer_z);
    standard_drawer(middle_drawer_z);
    low_dust_drawer(low_drawer_z);

    if (show_drawer_fronts) {
        drawer_facade(bottom_drawer_z, drawer_front_height);
        drawer_facade(middle_drawer_z, drawer_front_height);
        drawer_facade(low_drawer_z, drawer_low_front_height);
    }
}

// ------------------------------------------------------------
// Worktop
// ------------------------------------------------------------
module worktop() {
    color(worktop_color)
        translate([0, 0, frame_height])
            cube([stand_length, stand_depth, worktop_thickness]);
}

module reference_floor() {
    color(reference_floor_color)
        translate([-100, -100, -2])
            cube([stand_length + 200, stand_depth + 200, 2]);
}


