/*
Bosch GTS 10 XC project component.

The supplied STL is deliberately kept as the visual reference for v1.0.
No simplified/redesigned Bosch geometry is used.
*/

module bosch_gts10xc_reference() {
    // STL axes:
    // X = width, Y = height, Z = depth.
    // Rotate +90 degrees around X to use:
    // X = width, Y = depth, Z = height.
    //
    // Native STL depth runs approximately -44..634. The +634 Y translation
    // normalizes it to approximately 0..678 mm.
    color(saw_color)
        translate([
            saw_x,
            saw_y + 634,
            (show_casters ? caster_total_height : 0)
                + frame_height + worktop_thickness
                + saw_z_offset
        ])
            rotate([90, 0, 0])
                import("../external/bosch-gts10xc/Bosch_GTS_10_XC.stl", convexity=10);
}
