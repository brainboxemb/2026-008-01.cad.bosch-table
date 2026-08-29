/*
Bosch GTS 10 XC table stand v1.1
Main OpenSCAD entrypoint.
*/

include <config.scad>
include <assemblies/table.scad>

/* [View] */
view_mode = "assembly"; // [assembly,frame_only,wheels_only,saw_reference]

if (view_mode == "assembly") {
    table_assembly();
} else if (view_mode == "frame_only") {
    aluminium_base_frame();
} else if (view_mode == "wheels_only") {
    wheel_set();
} else if (view_mode == "saw_reference") {
    bosch_gts10xc_reference();
} else {
    table_assembly();
}
