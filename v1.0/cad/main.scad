/*
Bosch GTS 10 XC table stand v1.0

Reference implementation of:
https://pragmatic-workshop.amon.de/blog/my-bosch-gts-10-xc-stand/

This version intentionally follows the reference solution. Future versions can
adapt it to the separate aluminium 60-series mobile base and other changes.
*/

include <config.scad>
include <components/geometry-helpers.scad>
include <components/timber-frame.scad>
include <components/cabinet.scad>
include <components/casters.scad>
include <components/bosch-gts10xc-reference.scad>

module timber_stand_assembly() {
    if (show_frame) timber_frame();
    if (show_cabinet_panels) cabinet_panels();
    if (show_drawers) drawers();
    if (show_worktop) worktop();
}

module table_assembly() {
    if (show_reference_floor)
        reference_floor();

    if (show_casters)
        casters();

    translate([0, 0, show_casters ? caster_total_height : 0])
        timber_stand_assembly();

    if (show_saw_reference)
        bosch_gts10xc_reference();
}

module left_lower_corner_view() {
    // Same inspection crop used while verifying the corner half-lap.
    intersection() {
        timber_frame();
        translate([-10, -10, -10])
            cube([260, 260, 180]);
    }
}
