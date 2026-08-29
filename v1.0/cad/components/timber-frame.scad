/*
60 x 40 mm timber frame from the Pragmatic Workshop reference design.

The half-lap geometry is kept from the verified v0.11 reconstruction.
The three wood shades make vertical, longitudinal and transverse members
visually distinguishable.
*/

// ------------------------------------------------------------
// Timber members and half-lap cuts
// ------------------------------------------------------------

// Front/rear X rail. At every post location the inner half of the 40 mm
// rail thickness is removed for the post-to-rail half-lap.
//
// At both ends there is a SECOND joint, directly beside the corner post:
// the transverse rail lies beside the post and half-laps vertically into the
// longitudinal rail. At the overlap the longitudinal rail loses its TOP 20 mm
// and the transverse rail loses its BOTTOM 20 mm. Their top faces align.
module longitudinal_rail(y, z, rear=false) {
    left_cross_x  = post_x;
    right_cross_x = stand_length - post_x - timber_face;

    color(timber_longitudinal_color)
        translate([0, y, z])
            difference() {
                rounded_prism_x(
                    stand_length,
                    rail_depth,
                    rail_height,
                    timber_edge_radius
                );

                if (use_half_lap_joinery) {
                    // Half-laps with vertical posts.
                    for (px = [left_post_x, center_post_x, right_post_x]) {
                        cut_y = rear ? -EPS : half_lap_depth - half_lap_clearance/2;
                        cut_d = half_lap_depth + half_lap_clearance/2 + 2*EPS;

                        translate([
                            px - half_lap_clearance/2,
                            rear ? -EPS : cut_y,
                            -EPS
                        ])
                            cube([
                                post_x + half_lap_clearance,
                                cut_d,
                                rail_height + 2*EPS
                            ]);
                    }

                    // Half-laps with transverse rails BESIDE the corner posts.
                    // Remove only the TOP 20 mm from the 60 mm high longitudinal
                    // rail. The complementary transverse notch removes its
                    // BOTTOM 20 mm, creating a true half-lap.
                    for (cx = [left_cross_x, right_cross_x])
                        translate([
                            cx - half_lap_clearance/2,
                            -EPS,
                            rail_height - half_lap_depth - half_lap_clearance/2
                        ])
                            cube([
                                timber_face + half_lap_clearance,
                                rail_depth + 2*EPS,
                                half_lap_depth
                                    + half_lap_clearance/2 + 2*EPS
                            ]);
                }
            }
}

// Full-depth Y rail. Its 60 mm face is horizontal/up, therefore it is
// 60 mm wide in X and 40 mm high in Z. It sits BESIDE the corner post:
// left rail at X=60, right rail at X=980 for a 1100 mm frame.
//
// At front and rear it overlaps the longitudinal rail over 40 mm in Y.
// The LOWER 20 mm is removed from the transverse rail there, complementing
// the upper 20 mm removed from the longitudinal rail. The transverse member
// is therefore visibly on top at the joint.
module cross_rail(x, z, notch_underside=true) {
    color(timber_transverse_color)
        translate([x, 0, z])
            difference() {
                rounded_prism_y(
                    stand_depth,
                    timber_face,
                    timber_depth,
                    timber_edge_radius
                );

                if (use_half_lap_joinery && notch_underside) {
                    for (jy = [0, stand_depth - rail_depth])
                        translate([
                            -EPS,
                            jy - EPS,
                            -EPS
                        ])
                            cube([
                                timber_face + 2*EPS,
                                rail_depth + 2*EPS,
                                half_lap_depth + half_lap_clearance/2 + EPS
                            ]);
                }
            }
}

// Vertical post. It only half-laps with the front/rear longitudinal rail.
// The transverse rail is deliberately NOT cut into the post: it is positioned
// immediately beside the post, as visible in the supplied corner photograph.
module timber_post(x, y, rear=false, side="none") {
    top_rail_z = frame_height - rail_height;

    color(timber_vertical_color)
        translate([x, y, 0])
            difference() {
                rounded_prism_z(
                    frame_height,
                    post_x,
                    post_y,
                    timber_edge_radius
                );

                if (use_half_lap_joinery) {
                    for (jz = [0, top_rail_z]) {
                        cut_y = rear
                            ? half_lap_depth - half_lap_clearance/2
                            : -EPS;

                        translate([
                            -EPS,
                            cut_y,
                            jz - EPS
                        ])
                            cube([
                                post_x + 2*EPS,
                                half_lap_depth + half_lap_clearance/2 + 2*EPS,
                                rail_height + 2*EPS
                            ]);
                    }
                }
            }
}

// ------------------------------------------------------------
// Timber frame
// ------------------------------------------------------------
module timber_frame() {
    top_rail_z = frame_height - rail_height;
    rear_y = stand_depth - rail_depth;

    // Four 1100 mm longitudinal rails: front/rear, lower/upper.
    longitudinal_rail(0,      0,          false);
    longitudinal_rail(rear_y, 0,          true);
    longitudinal_rail(0,      top_rail_z, false);
    longitudinal_rail(rear_y, top_rail_z, true);

    // Four 670 mm transverse rails. They sit beside, not through, the
    // corner posts.
    left_cross_x  = post_x;
    right_cross_x = stand_length - post_x - timber_face;
    // Transverse rails are 40 mm high and are top-aligned with each 60 mm
    // longitudinal rail. Therefore their base is 20 mm above the longitudinal
    // rail base. At each crossing both members are notched by 20 mm.
    cross_rail(left_cross_x,  half_lap_depth, true);
    cross_rail(right_cross_x, half_lap_depth, true);
    cross_rail(left_cross_x,  top_rail_z + half_lap_depth, true);
    cross_rail(right_cross_x, top_rail_z + half_lap_depth, true);

    // Six 441 mm posts: four corner posts and the front/rear pair at the
    // division between the 600 mm clear drawer bay and the open bay.
    timber_post(left_post_x,   0,      false, "left");
    timber_post(left_post_x,   rear_y, true,  "left");
    timber_post(center_post_x, 0,      false, "none");
    timber_post(center_post_x, rear_y, true,  "none");
    timber_post(right_post_x,  0,      false, "right");
    timber_post(right_post_x,  rear_y, true,  "right");
}

