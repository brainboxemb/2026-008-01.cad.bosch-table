/*
Bosch GTS 10 XC external reference wrapper.
Used only as an optional scale/placement reference in v1.1.
*/

module bosch_gts10xc_reference() {
    color(saw_color)
        translate([saw_x, saw_y + 634, saw_z])
            rotate([90, 0, 0])
                import("../external/bosch-gts10xc/Bosch_GTS_10_XC.stl",
                       convexity=10);
}
