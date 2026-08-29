/*
Bosch GTS 10 XC table stand v1.0
Table assembly.
*/

include <../config.scad>
include <../components/geometry-helpers.scad>
include <../components/casters.scad>
include <../components/bosch-gts10xc-reference.scad>
include <../project-components/timber-frame.scad>
include <../project-components/cabinet.scad>

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
    intersection() {
        timber_frame();
        translate([-10, -10, -10])
            cube([260, 260, 180]);
    }
}
