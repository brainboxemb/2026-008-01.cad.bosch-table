/*
Bosch GTS 10 XC table stand v1.1
Table assembly.

v1.1 starts from the custom 1060 x 670 mm aluminium mobile base.
*/

include <../config.scad>
include <../project-components/aluminium-base-frame.scad>
include <../components/bosch-gts10xc-reference.scad>

module table_assembly() {
    if (show_floor)
        floor_reference();

    aluminium_base_frame();
    wheel_set();

    if (show_saw_reference)
        bosch_gts10xc_reference();
}
